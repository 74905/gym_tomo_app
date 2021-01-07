class Room < ApplicationRecord
  geocoded_by :address #(←住所のカラム名)
  after_validation :geocode, if: :address_changed?
  
  attachment :image
end
