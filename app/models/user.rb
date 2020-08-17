class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[discord]

  def self.from_omniauth(auth)
    puts "User#from_omniauth(#{auth.inspect})"

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]

      case auth.provider.to_sym
      when :discord
        user.avatar_url = auth.info.image
        user.name = auth.info.name

        user.discord_username = auth.extra.raw_info.username
        user.discord_discriminator = auth.extra.raw_info.discriminator
        user.discord_token = auth.credentials.token
        user.discord_refresh_token = auth.credentials.refresh_token
        user.discord_token_expires = auth.credentials.expires
        user.discord_token_expires_at = auth.credentials.expires_at
      end

      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
