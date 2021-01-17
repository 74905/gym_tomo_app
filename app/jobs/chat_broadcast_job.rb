class ChatBroadcastJob < ApplicationJob
  queue_as :default

  def perform(chat)
     ActionCable.server.broadcast "chat_channel_#{chat.room_id}", chat: render_chat(chat) #下からとってきたテンプレートを上記に代入しブロードキャスト
    # Do something later
  end
  
  private
  def render_chat(chat)
    ApplicationController.render_with_signed_in_user(chat.user, partial: 'chats/chat', locals: { chat: chat })
    #ここで追加したいHTMLのテンプレートをコントローラーからとってくる　レシーブの際にデータを取りに行かなくていい　追記　current_userが取れないので、コントローラーに新たに定義
  end
end
