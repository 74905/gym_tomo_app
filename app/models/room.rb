class Room < ApplicationRecord
  geocoded_by :address #(←住所のカラム名)
  after_validation :geocode, if: :address_changed?
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  validates :name, presence: true
  validates :zipcode, presence: true
  validates :address, presence: true
  VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/ #こいつでハイフンありの固定電話
  validates :phone_number, presence: true, format: { with: VALID_PHONE_NUMBER_REGEX }
  
  attachment :image
  
  def self.search(search)
      Room.where(["name LIKE ?", "%#{search}%"])
  end
end
