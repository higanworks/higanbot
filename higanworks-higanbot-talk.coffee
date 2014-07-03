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
    words = ["そうだね！", "はい？", "それは違うんじゃないかな"]
    msg.send msg.random words

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

  robot.hear /^うん$/i, (msg) ->
    msg.send "なるほど！"

  robot.hear /ありがとう/i, (msg) ->
    msg.send "どういたしまして！"

  robot.hear /^はい/i, (msg) ->
    words = ["良い返事だ", "はいだけはしっかりしてるね", "ほんとにわかってる？"]
    msg.send msg.random words

  robot.hear /おはよ/i, (msg) ->
    words = ["おはようございます！", "いまごろ？", "帰っていいよ"]
    msg.send msg.random words

  robot.hear /higanくん|higan君/i, (msg) ->
    words = ["おっす", "なに？", "気安く呼ばないでもらえますか"]
    msg.send msg.random words

  robot.hear /？$/i, (msg) ->
    words = ["どうだろ", "いいと思います！", "それは違うんじゃないのかな？", "!!??", ".........!?"]
    msg.send msg.random words

  robot.hear /orz$/i, (msg) ->
    msg.send "イキロ"

  robot.hear /ー$/i, (msg) ->
    words = ["語尾をのばすと馬鹿に見える", "語尾をのばすと柔らかい印象あたえますよね", "伸ばすなー"]
    msg.send msg.random words

  robot.hear /ごめん|すまん|すいま|すみま/i, (msg) ->
    words = ["気にしないで！", "謝れば良いと思ってる？", "あーっと心にもない言葉！", "聞こえないなぁ？"]
    msg.send msg.random words

  robot.hear /w$|ｗ$|笑/i, (msg) ->
    words = ["笑うなー", "ｗｗｗ", "面白くないよ", "ｗ"]
    msg.send msg.random words

  robot.hear /お願い/i, (msg) ->
    words = ["嫌", "了解しました！", "断固断る！", "ggrks"]
    msg.send msg.random words

  robot.hear /意識高い/i, (msg) ->
    words = ["たかいたかーい", "意識高い系です", "意識高めていくぅっっ！！", "尊敬します"]
    msg.send msg.random words

