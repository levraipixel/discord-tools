class Team < ApplicationRecord

  validates :short_name, presence: true
  validates :name, presence: true

end
