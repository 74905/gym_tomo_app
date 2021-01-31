 App.chat = App.cable.subscriptions.create { channel: "ChatChannel", room_id: location.pathname.replace(/[^0-9]/g,'') },
   connected: ->
    # Called when the subscription is ready for use on the server
   disconnected: ->
    # Called when the subscription has been terminated by the server

   received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    if data['id']
     id = ('#') + data['id']
     $(id).remove()
   
    else  
     show_user = $('#show_user').data('show_user')
     if data['chat_user'] == show_user
      $('#chats').append data['chat']
      $('.chat_box').animate scrollTop: $('.chat_box')[0].scrollHeight
     else
      $('#chats').append data['chatother']
      $('.chat_box').animate scrollTop: $('.chat_box')[0].scrollHeight
   destroy: (id) ->
    @perform 'destroy', id: id
   speak: (chat) ->
    @perform 'speak', chat: chat, room_id: $('#messages').data('room_id')
  
    
 $(document).on 'click', '.chat_submit', (event) ->
  #App.chat.speak event.target.value
  App.chat.speak $('[data-behavior~=chat_speaker]').val()
  $('[data-behavior~=chat_speaker]').val('')
  event.preventDefault()

 $(document).on 'click', '.delete-btn', (event) ->
    App.chat.destroy event.target.id