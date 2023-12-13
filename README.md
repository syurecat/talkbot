ディスコード対話ボット
====
## 概要？
A3RT APIを使用しメンションすると話してくれます。技能向上のために真似て作りました。~~コード汚いけど許して（量全然ない）~~
最初完コピで作ったら動かなかったので、恐らくチャットのメッセージの取得の仕様が変わったのだと思います。（違ったら教えてください）
discordは日本語が少ないので、なにかの手助けになると幸いです。
細かいところは初心者なんで許して下さい......教えていただけると助かります！
## miibo
現在miiboに対応中です。詳しくはmiibo brancheを参考にしてください。
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