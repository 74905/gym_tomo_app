document.addEventListener 'turbolinks:load', ->
 App.chat = App.cable.subscriptions.create { channel: "ChatChannel", room_id: $('#messages').data('room_id') },
  connected: ->
    # Called when the subscription is ready for use on the server
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
     $('#chats').append data['chat']
  speak: (chat) ->
    @perform 'speak', chat: chat
  
  # $(document).on 'keypress', '[data-behavior~=chat_speaker]', (event) ->
  # if event.keyCode is 13 # return = send
  #   App.chat.speak event.target.value
  #   event.target.value = ''
  #   event.preventDefault()
  
  # Viewの'[data-behavior~=room_speaker]'内のtextを引数に実行される
# eventはここでは'[data-behavior~=room_speaker]'にあたる
$(document).on 'keydown', '[data-behavior~=chat_speaker]', (event) ->
  # Ctrl + returnキーを押すとここで上のApp.roomの:speakが呼ばれる
  if event.ctrlKey && event.keyCode is 13
    # 引数eventのvalueをspeakアクションに渡す
    App.chat.speak event.target.value
    # eventのvalueを初期化
    event.target.value = ''
    # 中身をsubmitしない
    event.preventDefault()
    
$(document).on 'click', '.chat_submit', ->
  App.chat.speak $('[data-behavior~=chat_speaker]').val()
  $('[data-behavior~=chat_speaker]').val('')
  event.preventDefault()