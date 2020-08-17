class Message < ApplicationRecord

  belongs_to :channel

  validates :author, presence: true
  validates :content, presence: true

  def self.import!(data)
    message = where(discord_id: data['id']).first_or_initialize
    message.attributes = {
      channel: Channel.find_by!(discord_id: data['channel_id']),
      author: data['author']['username'],
      content: data['content']
    }
    message.save!
    message
  end

end
