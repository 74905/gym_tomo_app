class ChatsController < ApplicationController
  def index
    room = Room.find(params[:id])
    user_rooms = UserRoom.find_by(user_id: current_user.id, room_id: room)
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      UserRoom.create(user_id: current_user.id, room_id: room.id)
      @room = room 
    end
    @chats = @room.chats  
    @chat = Chat.new
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    redirect_to request.referer
  end
  
   private
    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end
end
