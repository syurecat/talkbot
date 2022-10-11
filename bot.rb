require 'discordrb' #discordとのやり取りのため追加
require 'uri' #HTTP通信をするため追加

TALK_BOT_TOKEN = ENV["TALK_BOT_TOKEN"].freeze
TALK_BOT_CLIENT_ID = ENV["TALK_BOT_CLIENT_ID"].freeze
TALK_API_KEY = ENV["TALK_API_KEY"]

#botのセットアップ
bot = Discordrb::Commands::CommandBot.new(
    token: TALK_BOT_TOKEN,
    client_id: TALK_BOT_CLIENT_ID,
    prefix: "$"
)

#A3RTのAPI URLとライセンスキーを記載
api_url = "https://api.a3rt.recruit.co.jp/talk/v1/smalltalk" #共通だが、変更がある場合などがあり注意
api_key = TALK_API_KEY #なんでもう一回代入したんだろう......

bot.mention do |event|
    #メッセージの取得とメンション部分の削除
    message = event.message.content
    message = message.delete("<@1025728623208058900> ")

    #API通信
    uri = URI.parse(api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({'apikey' => api_key, 'query' => message})
    res = http.request(req)
    result = JSON.parse(res.body)

    #レスポンスの取得
    message = result["status"] == 0 ? result["results"][0]["reply"] : "error";

    event.respond message
end

bot.command :help do |event|
    bot.send_message("メンションの後に話したい内容を入れると、このボットが話してくれます。")
end

bot.run