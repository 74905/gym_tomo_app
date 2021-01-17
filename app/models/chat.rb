class Chat < ApplicationRecord
  after_create_commit { ChatBroadcastJob.perform_later self }
  #after_destroy_commit { DeleteBroadcastJob.perform_later self.id }
  belongs_to :user
  belongs_to :room
end
