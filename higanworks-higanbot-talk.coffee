# Description:
#   幾つかの日本語に反応するよ
#
# Dependencies:
#   None
# 
# Configuration:
#   None
#
# Commands:
#   None
#
# Notes:
#   幾つかの日本語に反応するよ
#
# Author:
#   MATSUMOTO, Ryosuke

module.exports = (robot) ->
  robot.hear /おーい/i, (msg) ->
    msg.send "なに？"

  robot.hear /よ$/i, (msg) ->
    msg.send "そうだね！"

  robot.hear /よね$/i, (msg) ->
    msg.send "そうかな？"

  robot.hear /やん$/i, (msg) ->
    msg.send "なんでやねん！"

  robot.hear /ねむい|眠い|ネムイ/i, (msg) ->
    msg.send "ねろ"

  robot.hear /つかれた|疲れた/i, (msg) ->
    msg.send "コーヒー飲め"

  robot.hear /error|broken|fail/i, (msg) ->
    msg.send "/(vv)\ 失敗です"

  robot.hear /fixed|success|passed/i, (msg) ->
    msg.send "v(^^)v OKです"

  robot.hear /test|てすと|テスト/i, (msg) ->
    msg.send "v(oo)v テストですか！"

