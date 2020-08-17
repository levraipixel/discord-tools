class DiscordApi

  CDN_URL = 'https://cdn.discordapp.com'.freeze

  def initialize(app_token:, bot_token: nil)
    @app_token = app_token
    @bot_token = bot_token || ENV['DISCORD_BOT_TOKEN']
  end

  def current_user
    app_get '/users/@me'
  end

  def current_user_guilds
    bot_get '/users/@me/guilds'
  end

  def guild(guild_id)
    bot_get "/guilds/#{guild_id}"
  end

  def guild_channels(guild_id)
    bot_get "/guilds/#{guild_id}/channels"
  end

  def channel(channel_id)
    bot_get "/channels/#{channel_id}"
  end

  def channel_messages(channel_id)
    bot_get "/channels/#{channel_id}/messages?limit=100"
  end

  def icon_url(server_id, icon_id, format: 'png', size: 32)
    "#{CDN_URL}/icons/#{server_id}/#{icon_id}.#{format}?size=#{size}"
  end

  def avatar_url(user_id, avatar_id, format: 'png', size: 32)
    "#{CDN_URL}/avatars/#{user_id}/#{avatar_id}.#{format}?size=#{size}"
  end

  private

  def app_get(path)
    api_get path, "Bearer #{@app_token}"
  end

  def bot_get(path)
    api_get path, "Bot #{@bot_token}"
  end

  def api_get(path, auth)
    puts "=== API REQUEST ==="
    url = URI("https://discord.com/api#{path}")
    puts "GET #{url}"

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["Authorization"] = auth

    response = https.request(request)

    JSON.parse(response.read_body)
  end

end
