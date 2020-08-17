class City < ApplicationRecord

  validates :icon, presence: true
  validates :name, presence: true

end
