# Description:
#   show tag list
#
# Dependencies:
#   "githubot": "0.4.x"
# 
# Configuration:
#   HUBOT_GITHUB_TOKEN
#   HUBOT_GITHUB_USER
#   HUBOT_GITHUB_API
#
# Commands:
#   hubot tag show <repo> - shows newest tag of repository
#   hubot tags show <repo> - shows tag list of repository
#
# Notes:
#   HUBOT_GITHUB_API allows you to set a custom URL path (for Github enterprise users)
#
# Author:
#   MATSUMOTO, Ryosuke

module.exports = (robot) ->
  github = require("githubot")(robot)
  robot.respond /tags show (.*)$/i, (msg) ->
    repo = github.qualified_repo msg.match[1]
    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    url = "#{base_url}/repos/#{repo}/tags"

    github.get url, (tags) ->
      if tags.message
        msg.send "#{repo} #{tags.message}!"
      else if tags.length == 0
        msg.send "#{repo} no tags name found!"
      else
        send = 5
        for tag in tags
          if send
            msg.send "[#{repo} tag: #{tag.name}] download tar.gz: #{tag.tarball_url}"
            send -= 1

  robot.respond /tag show (.*)$/i, (msg) ->
    repo = github.qualified_repo msg.match[1]
    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    url = "#{base_url}/repos/#{repo}/tags"

    github.get url, (tags) ->
      if tags.message
        msg.send "#{repo} #{tags.message}!"
      else if tags.length == 0
        msg.send "#{repo} no tags name found!"
      else
        send = 1
        for tag in tags
          if send
            msg.send "[#{repo} newest tag: #{tag.name}] download tar.gz: #{tag.tarball_url}"
            send -= 1
