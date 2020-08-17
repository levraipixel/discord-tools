class Channel < ApplicationRecord

  belongs_to :guild
  belongs_to :parent, class_name: :Channel, optional: true
  has_many :children, class_name: :Channel, foreign_key: :parent_id
  has_many :messages, dependent: :destroy

  validates :name, presence: true
  validates :position, presence: true

  def self.import!(data)
    channel = where(discord_id: data['id']).first_or_initialize
    channel.parent = Channel.find_by!(discord_id: data['parent_id']) unless data['parent_id'].blank?
    channel.attributes = {
      guild: Guild.find_by!(discord_id: data['guild_id']),
      name: data['name'],
      position: data['position'],
      topic: data['topic']
    }
    channel.save!
    channel
  end

  def self.without_parent
    where(parent_id: nil)
  end

end
