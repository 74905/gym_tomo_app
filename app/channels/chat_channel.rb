class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
      #ActionCable.server.broadcast 'chat_channel', chat: data['chat']
      Chat.create! message: data['chat'], user_id: current_user.id, room_id: params['room_id']
  end
  
  def destroy(data)
  end 
end
