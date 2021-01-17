class ChatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat)
     ActionCable.server.broadcast "chat_channel_#{chat.room_id}", chat: render_chat(chat) #下からとってきたテンプレートを上記に代入
    # Do something later
  end
  
  private
  def render_chat(chat)
    ApplicationController.renderer.render(partial: 'chats/chat', locals: { chat: chat })  #ここで追加したいHTMLのテンプレートをコントローラーからとってくる　レシーブの際にデータ取得が楽
    
  end
end
