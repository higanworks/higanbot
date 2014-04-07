# Description:
#   tracing tag and release if finding new tag
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
#   hubot release serverspec - run newest serverspec CI if existing newest tag
#
# Notes:
#   HUBOT_GITHUB_API allows you to set a custom URL path (for Github enterprise users)
#
# Author:
#   MATSUMOTO, Ryosuke

module.exports = (robot) ->

  github = require("githubot")(robot)
  robot.respond /release serverspec$/i, (msg) ->
    repo = github.qualified_repo "serverspec/serverspec"
    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    url = "#{base_url}/repos/#{repo}/tags"

    github.get url, (tags) ->
      if tags.message
        msg.send "#{repo} #{tags.message}!"
      else if tags.length == 0
        msg.send "#{repo} no tags name found!"
      else
        send = 1
        key = "serverspec_newest_tag"
        for tag in tags
          if send
            if not robot.brain.data[key]
              robot.brain.data[key] = tag.name
              msg.send "#{key} is not found. Insert newest tag:#{tag.name} into brain.data[#{key}]"
            else
              if robot.brain.data[key] != tag.name
                robot.brain.data[key] = tag.name
                msg.send "found serverspec newest tag, connect CI for serverspec release"
                #
                # implemten serverspec relase code
                #
              else
                msg.send "HiganBot not found serverspec newest tag.\n  brain stored tag: #{robot.brain.data[key]}\n  current repo tag: #{tag.name}"

            robot.brain.save()
            send -= 1

