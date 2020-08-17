class GuildsController < ApplicationController

  def index
    @guilds = discord.current_user_guilds
  end

  def import
    guild_id = params[:id]

    guild = nil

    # guild
    guild_data = discord.guild guild_id
    guild = Guild.import!(guild_data)

    # channels
    channels = discord.guild_channels guild_id
    channels.sort_by{|d| d['parent_id'] || ''}.each do |channel_data|
      # channel
      channel = Channel.import!(channel_data)
      next if channel.is_imported?

      # messages
      messages = discord.channel_messages channel_data['id']
      unless messages.is_a?(Hash) && messages['code'] == 50001
        messages.each do |message|
          Message.import!(message) unless message['content'].blank?
        end
      end

      channel.update_attribute :is_imported, true
    end

    redirect_to guild, notice: "Success"
  end

  def show
    @guild = Guild.find(params[:id])
  end

end
