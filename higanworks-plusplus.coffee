# Description:
#   ++
#
# Dependencies:
#   None
# 
# Configuration:
#   None
#
# Commands:
#   ${string}++
#
# Notes:
#   ++してお互い承認していこう
#
# Author:
#   MATSUMOTO, Ryosuke

module.exports = (robot) ->
  robot.hear /^(.+)\+\+$/i, (msg) ->
    user = msg.match[1].replace(/\s/g, "")
 
    if not robot.brain.data[user]
      robot.brain.data[user] = 0
 
    robot.brain.data[user]++
    robot.brain.save()
 
    msg.send robot.brain.data[user]

