document.addEventListener 'turbolinks:load', ->
 App.delete = App.cable.subscriptions.create "DeleteChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('.message_' + data['id']).remove() #二度と使うことはないが字下げでヘンテコなエラーになる
  delete: (id) ->
    @perform 'delete', id: id
    
    
  $(document).on 'click', '.delete-btn', (event) ->
    App.delete.delete event.target.id
    event.target.value = ''
    
