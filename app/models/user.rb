class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 validates :name, presence: true, length: { in: 2..15 }, uniqueness: true
  has_many :active_relationships, class_name: "Relationship",
                                 foreign_key: "follower_id",
                                 dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  attachment :profile_image
         
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
  
  # def is_member?(room_id)
  #   Room.find(room_id).users.exists?(self.id)
  # end
  def self.gesut
     find_or_create_by!(email: "guest@example.com", name: "ボディビル君") do |user|
      user.password = SecureRandom.urlsafe_base64
     end
  end
  
  def self.gesut2
    find_or_create_by!(email: "guest2@example.com", name: "フィジーク君") do |user|
      user.password = SecureRandom.urlsafe_base64
     end
  end
end