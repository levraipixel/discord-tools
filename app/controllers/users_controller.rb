class UsersController < ApplicationController

  def current
    @user = discord.current_user

    render :show
  end

end
