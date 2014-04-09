# Description:
#   None
#
# Dependencies:
#   "date-utils": ">=1.2.5"
#   "githubot": "0.4.x"
# 
# Configuration:
#   HUBOT_GITHUB_TOKEN
#   HUBOT_GITHUB_USER
#   HUBOT_GITHUB_API
#
# Commands:
#   hubot commit show :user/:repo - shows newest commit of repository
#   hubot commits show :user/:repo - shows commit list of repository
#
# Notes:
#   HUBOT_GITHUB_API allows you to set a custom URL path (for Github enterprise users)
#
# Author:
#   MATSUMOTO Ryosuke

require('date-utils')

module.exports = (robot) ->
  github = require("githubot")(robot)

  robot.respond /commits show (.*)$/i, (msg) ->
    repo = github.qualified_repo msg.match[1]
    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    url = "#{base_url}/repos/#{repo}/commits"

    github.get url, (commits) ->
      if commits.message
        msg.send "#{repo} has message: #{commits.message}!"
      else if commits.length == 0
          msg.send "#{repo} no commits found!"
      else
        send = 5
        for c in commits
          if send
            d = new Date(Date.parse(c.commit.committer.date)).toFormat("DD/MM HH24:MI")
            msg.send "[#{d} -> #{c.commit.committer.name}] #{c.commit.message}"
            send -= 1

  robot.respond /commit show (.*)$/i, (msg) ->
    repo = github.qualified_repo msg.match[1]
    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    url = "#{base_url}/repos/#{repo}/commits"

    github.get url, (commits) ->
      if commits.message
        msg.send "#{repo} has message: #{commits.message}!"
      else if commits.length == 0
          msg.send "#{repo} no newest commits found!"
      else
        d = new Date(Date.parse(commits[0].commit.committer.date)).toFormat("DD/MM HH24:MI")
        msg.send "[#{d} -> #{commits[0].commit.committer.name}] #{commits[0].commit.message}"
