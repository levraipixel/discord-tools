class ApplicationController < ActionController::Base

  helper_method :discord

  def home
  end

  def convert
    # cities
    Channel.find_by(discord_id: '737461480508620820').children.where.not(name: 'topic-admin').each do |channel|
      icon, name = channel.name.first, channel.name[1..-1]
      City.where(name: name).first_or_create!(icon: icon)
    end
    render plain: 'OK'
  end

  protected

  def discord
    DiscordApi.new app_token: current_user.discord_token
  end

end
