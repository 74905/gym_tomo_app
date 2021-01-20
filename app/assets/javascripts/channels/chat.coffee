document.addEventListener 'turbolinks:load', ->
 App.chat = App.cable.subscriptions.create { channel: "ChatChannel", room_id: $('#messages').data('room_id') },
  connected: ->
    # Called when the subscription is ready for use on the server
  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
     $('#chats').append data['chat']
    # id = '#' + data['id']
    # $(id).remove()
  speak: (chat) ->
    @perform 'speak', chat: chat
    #現状アクションを増やすことはできないことが
    # Viewの'[data-behavior~=chat_speaker]'内のtextを引数に実行される
   # eventはここでは'[data-behavior~=chat_speaker]'にあたる
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
    