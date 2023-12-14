ディスコード対話ボット
====
## 重要！
うごいてないよ＾＾

## 概要？
miiboを使用しメンションすると話してくれます。技能向上のために作りました。~~コード汚いけど許して（量全然ない）~~
discordは日本語が少ないので、なにかの手助けになると幸いです。

## 招待リンク
個人的な都合で止まっているかもしれませんが。
[discordbotの招待リンク](https://discord.com/api/oauth2/authorize?client_id=1025728623208058900&permissions=67584&scope=bot)
## 動作
![demo](/gif/demo.gif)
## status2000について
使用している際にメッセージが帰ってこないことかあったので調べてみたところ、status2000が返ってきていたので問い合わせてみたところ、
> Talk APIではqueryに対して応答文生成を行っておりますが、破綻した応答文を生成してしまうと判断できるような場合に status : 2000（empty reply）を返却する仕様となっております。
> status : 2000（empty reply）が返却される場合には入力文を変更してお試し頂けますと幸いです。

とのことですが、頻度が高いため（長文になるほど増える？）適当な言葉を返すよう変更しました。
## 環境変数
TALK_BOT_TOKENにbotのtoken,TALK_BOT_CLIENT_IDにbotのチャンネルID,TALK_API_KEYにA3RTのtalk APIのライセンスキーを代入してご使用ください。
## 参考
[【Ruby】discordの対話botを作成する-Qiita](https://qiita.com/anomeme/items/4863d131e228b22dbab8)
[会話のラリーができるAIのAPIを公開した話【会話AI構築サービスmebo】-Qiita](https://qiita.com/maKunugi/items/14f1b82a2c0b6fa5c202)