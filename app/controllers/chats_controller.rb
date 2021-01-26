class ChatsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    room = Room.find(params[:room_id])
    user_rooms = UserRoom.find_by(user_id: current_user.id, room_id: room)
    unless user_rooms.nil?
      @room = user_rooms.room
    else
    user_rooms = UserRoom.create(user_id: current_user.id, room_id: room.id)
      @room = user_rooms.room 
    end
    @chats = @room.chats.last(100)
  end
  
  def destroy
   @chat = Chat.find_by(id: params[:id], room_id: params[:room_id])
   if @chat.user == current_user
     @chat.destroy
     redirect_to room_chats_path(params[:room_id])
   else
     redirect_to room_chats_path(params[:room_id])
   end
  end
  
   private
    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end
end
