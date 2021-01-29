class Chat < ApplicationRecord
  #after_create_commit {  ActionCable.server.broadcast_later self }
  # after_destroy_commit { DeleteBroadcastJob.perform_later self.id }
  validates :message, presence: true
  belongs_to :user
  belongs_to :room
end
