class Room < ApplicationRecord
  geocoded_by :address #(←住所のカラム名)
  after_validation :geocode, if: :address_changed?
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  validates :name, presence: true
  validates :zipcode, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :address, presence: true
  validates :phone_number, presence: true
  
  attachment :image
  
  def self.search(search)
      Room.where(["name LIKE ?", "%#{search}%"])
  end
end
