require 'discordrb' #discordとのやり取りのため追加
require 'uri' #HTTP通信をするため追加

BOT_TOKEN = ENV["TALK_BOT_TOKEN"]
BOT_CLIENT_ID = ENV["TALK_BOT_CLIENT_ID"]
TALK_API_KEY = ENV["TALK_API_KEY"]
talkapi_url = "https://api.a3rt.recruit.co.jp/talk/v1/smalltalk" 

#botのセットアップ
bot = Discordrb::Commands::CommandBot.new(
    token: BOT_TOKEN,
    client_id: BOT_CLIENT_ID,
    prefix: "$"
)

bot.mention do |event|
    #メッセージの取得とメンション部分の削除
    message = event.message.content
    message = message.delete("<#{BOT_CLIENT_ID}> ")
    p message

    #API通信
    uri = URI.parse(talkapi_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({'apikey' => TALK_API_KEY, 'query' => message})
    res = http.request(req)
    result = JSON.parse(res.body)

    #レスポンスの取得
    message = result["status"] == 0 ? result["results"][0]["reply"] : "error#{result["status"]}\r\nmessege#{result["message"]}";

    event.respond message
end

bot.command :help do |event|
    bot.send_message("メンションの後に話したい内容を入れると、このボットが話してくれます。")
end

bot.run