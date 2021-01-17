class Room < ApplicationRecord
  has_many :chats
  has_many :user_rooms
  geocoded_by :address #(←住所のカラム名)
  after_validation :geocode, if: :address_changed?
  
  attachment :image
end
