class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
      chat = Chat.create! message: data['chat'], user_id: current_user.id, room_id: data['room_id']
      ActionCable.server.broadcast "chat_channel_#{params['room_id']}", chat: render_chat(chat), chatother: render_chatother(chat), chat_user: current_user.id
  end
  
  def destroy(data)
    Chat.find_by(id: data['id']).destroy
   ActionCable.server.broadcast "chat_channel_#{params['room_id']}", id: data['id']
  end
  
  private
  
  def render_chat(chat)
    ApplicationController.renderer.render( partial: 'chats/chatcurrent', locals: { chat: chat, current_user: current_user})
    #ここで追加したいHTMLのテンプレートをコントローラーからとってくる　レシーブの際にデータを取りに行かなくていい
  end
  
  def render_chatother(chat)
    ApplicationController.renderer.render( partial: 'chats/chatother', locals: { chat: chat, current_user: current_user})
    #ここで追加したいHTMLのテンプレートをコントローラーからとってくる　レシーブの際にデータを取りに行かなくていい　
  end
  
end
