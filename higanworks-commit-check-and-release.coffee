# Description:
#   Commit check and release on travis
#
# Dependencies:
#   "githubot": "0.4.x"
# 
# Configuration:
#   HUBOT_TRAVIS_ACCESS_TOKEN
#   HUBOT_GITHUB_TOKEN
#   HUBOT_GITHUB_USER
#   HUBOT_GITHUB_API
#
# Commands:
#   hubot travis release :release_user/:release_repo if commit :check_user/:check_repo
#
# Notes:
#   HUBOT_GITHUB_API allows you to set a custom URL path (for Github enterprise users)
#
# Author:
#   MATSUMOTO, Ryosuke

module.exports = (robot) ->

  github = require("githubot")(robot)
  robot.respond /travis release (.*) if commit (.*)$/i, (msg) ->
    restart_repo = github.qualified_repo msg.match[1]
    check_repo = github.qualified_repo msg.match[2]

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    url = "#{base_url}/repos/#{check_repo}/commits"

    github.get url, (commits) ->
      if commits.message
        msg.send "#{check_repo} #{commits.message}!"
      else if commits.length == 0
          msg.send "#{check_repo} no commits found!"
      else
        send = 1
        key = "#{check_repo}_newest_hash"
        for c in commits
          if send
            if not robot.brain.data[key]
              robot.brain.data[key] = c.sha
              msg.send "#{key} is not found. Insert newest commit hash:#{c.sha} into brain.data[#{key}]"
            else
              if robot.brain.data[key] != c.sha
                robot.brain.data[key] = c.sha
                msg.send "found #{check_repo} newest commit, connect travis and latest build restart for relase."
          
                # restart latest build for release
                travis_url = "https://api.travis-ci.org/repositories/#{restart_repo}/builds.json"
                msg.send "HiganBot restart Travis latest build of #{restart_repo}"
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
                          msg.send "HiganBot get result: #{json.result} notice: #{json.flash[0].notice}"
                    else
                      msg.send "HiganBot can not find #{repo}"
                msg.send "@HiganBot travis build restart #{restart_repo}"
              else
                msg.send "HiganBot not found #{check_repo} newest commit.\n  brain stored commit: #{robot.brain.data[key]}\n  current repo commit: #{c.sha}"
            robot.brain.save()
            send -= 1

