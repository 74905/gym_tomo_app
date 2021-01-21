class ChatsController < ApplicationController
  def index
    room = Room.find(params[:room_id])
    user_rooms = UserRoom.find_by(user_id: current_user.id, room_id: room)
    unless user_rooms.nil?
      @room = user_rooms.room
    else
    user_rooms = UserRoom.create(user_id: current_user.id, room_id: room.id)
      @room = user_rooms.room 
    end
    @chats = @room.chats  
    @chat = Chat.new
  end
  
  def destroy
  end
   private
    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end
end
