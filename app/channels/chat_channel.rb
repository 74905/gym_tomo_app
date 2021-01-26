class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
      #ActionCable.server.broadcast 'chat_channel', chat: data['chat']
      chat = Chat.create! message: data['chat'], user_id: current_user.id, room_id: params['room_id']
      ActionCable.server.broadcast "chat_channel_#{params['room_id']}", chat: render_chat(chat, current_user.id)
   
  end
  
  private
  
  def render_chat(chat, user_id)
    ApplicationController.render_with_signed_in_user(User.find(user_id), partial: 'chats/chat', locals: { chat: chat})
    #ここで追加したいHTMLのテンプレートをコントローラーからとってくる　レシーブの際にデータを取りに行かなくていい　追記　current_userが取れないので、コントローラーに新たに定義
  end
end
