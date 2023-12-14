require 'discordrb' #discordとのやり取りのため追加
require 'uri' #HTTP通信をするため追加

BOT_TOKEN = ENV["TALK_BOT_TOKEN"]
BOT_CLIENT_ID = ENV["TALK_BOT_CLIENT_ID"]
TALK_API_KEY = ENV["MIIBO_API_KEY"]
TALK_AGENT_ID = ENV["MIIBO_AGENT_ID"]
miibo_api_url = "https://api-mebo.dev/api" 

#botのセットアップ
bot = Discordrb::Commands::CommandBot.new(
    token: BOT_TOKEN,
    client_id: BOT_CLIENT_ID,
    prefix: "T"
)

bot.mention do |event|
    #メッセージの取得とメンション部分の削除
    message = event.message.content
    message = message.delete("<@#{BOT_CLIENT_ID}> ")
    server_id = event.server.id.to_s
    channel_id = event.channel.id.to_s
    cid = "discord_" + server_id + "." + channel_id
    p message
    p cid

    uri = URI.parse(miibo_api_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({
        'api_key' => TALK_API_KEY, 
        'agent_id' => TALK_AGENT_ID, 
        'utterance' => message, 
        'uid' => cid
    })
    
    p ({
        'api_key' => TALK_API_KEY, 
        'agent_id' => TALK_AGENT_ID, 
        'utterance' => message, 
        'uid' => cid
    })
    res_miibo = http.request(req)
    startus_miibo = res_miibo.code
    result_miibo = JSON.parse(res_miibo.body)
    p res_miibo.body

    if startus_miibo != 200 then
        p "error"
        p startus_miibo
        #API通信
        # uri = URI.parse(talkapi_url)
        # http = Net::HTTP.new(uri.host, uri.port)
        # http.use_ssl = true
        # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        # req = Net::HTTP::Post.new(uri.path)
        # req.set_form_data({'apikey' => TALK_API_KEY, 'query' => message})
        # res = http.request(req)
        # result = JSON.parse(res.body)

        #レスポンスの取得
        # message = result["status"] == 0 ? result["results"][0]["reply"] : "error#{result["status"]}\r\nmessege#{result["message"]}";

        # if result["status"] == 0 then
        #     message = result["results"][0]["reply"]
        # elsif result["status"] == 2000 then
        #     message = "すみません、よくわかりません"
        # else
        #     message = "error#{result["status"]}\r\nmessege#{result["message"]}";
        # end
    else
        message = result_miibo["bestResponse"]["utterance"]
    end

    p message
    event.respond message
end

bot.command :help do |event|
    bot.send_message("メンションの後に話したい内容を入れると、このボットが話してくれます。")
end

bot.run