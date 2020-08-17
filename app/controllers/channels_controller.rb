class ChannelsController < ApplicationController

  def index
    @guild = Guild.find(params[:guild_id])
    @channels = @guild.channels
  end

  def show
    channel_id = params[:id]

    @channel = Channel.find(params[:id])
    @messages = @channel.messages
  end

end
