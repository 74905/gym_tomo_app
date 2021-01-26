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
      ActionCable.server.broadcast "chat_channel_#{params['room_id']}", chat: render_chat(chat), chatother: render_chatother(chat), chat_user: current_user.id
  end
  
  private
  
  def render_chat(chat)
    ApplicationController.renderer.render( partial: 'chats/chat', locals: { chat: chat, current_user: current_user})
    #ここで追加したいHTMLのテンプレートをコントローラーからとってくる　レシーブの際にデータを取りに行かなくていい　追記　current_userが取れないので、コントローラーに新たに定義
  end
  
  def render_chatother(chat)
    ApplicationController.renderer.render( partial: 'chats/chatother', locals: { chat: chat, current_user: current_user})
    #ここで追加したいHTMLのテンプレートをコントローラーからとってくる　レシーブの際にデータを取りに行かなくていい　追記　current_userが取れないので、コントローラーに新たに定義
  end
  
end
