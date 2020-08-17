class Guild < ApplicationRecord

  has_many :channels, dependent: :destroy

  validates :name, presence: true

  def self.import!(data)
    where(discord_id: data['id']).first_or_create!(name: data['name'])
  end

end
