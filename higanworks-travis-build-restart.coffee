# Description:
#   Travis latest build restart
#
# Dependencies:
#   "githubot": "0.4.x"
# 
# Configuration:
#   HUBOT_TRAVIS_ACCESS_TOKEN
#   HUBOT_IDOBATA_HOOK_URL
#   HUBOT_GITHUB_TOKEN
#   HUBOT_GITHUB_USER
#   HUBOT_GITHUB_API
#
# Commands:
#   hubot travis build restart :user/:repo - latest build restart
#
# Notes:
#   HUBOT_GITHUB_API allows you to set a custom URL path (for Github enterprise users)
#
# Author:
#   MATSUMOTO, Ryosuke

QS = require "querystring"

module.exports = (robot) ->

  success = "<span class='label label-success'>Success</span>"
  failure = "<span class='label label-important'>Failure</span>"

  github = require("githubot")(robot)
  robot.respond /travis build restart (.*)$/i, (msg) ->
    repo = github.qualified_repo msg.match[1]
    travis_url = "https://api.travis-ci.org/repositories/#{repo}/builds.json"
    msg.send "HiganBot restart Travis latest build of #{repo}"

    msg.http(travis_url)
      .header('User-Agent', 'higan-hubot')
      .get() (err, res, body) ->
        data = body
        json = JSON.parse body
        if data.length > 4 and data[0] == '['
          msg.http("https://api.travis-ci.org/builds/#{json[0].id}/restart")
            .header("Authorization", "token #{process.env.HUBOT_TRAVIS_ACCESS_TOKEN}")
            .post() (err, res, body) ->
              json = JSON.parse body
              result = if json.result then success else failure
              message = "#{repo} build restart. result: #{result} : #{json.flash[0].notice}"
              post_data = QS.stringify source: message
              msg.http(process.env.HUBOT_IDOBATA_HOOK_URL)
                .query(format: "html")
                .header("Content-Type", "application/x-www-form-urlencoded")
                .post(post_data) (err, res, body) ->
                  data = body
        else
          msg.send "HiganBot can not find #{repo}"

