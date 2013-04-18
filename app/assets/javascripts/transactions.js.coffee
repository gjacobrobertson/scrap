# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

refreshNotifications = (evt, data, status, xhr) ->
  $('#notifications').html(data)

$('#notifications, #user-summary').on('ajax:success', '.refresh-trigger', refreshNotifications)
$('#edit-modal').on('ajax:success', 'form', refreshNotifications)

editSuccess = (evt, data, status, xhr) ->
  $('#edit-modal').modal('hide')

editFailure = (evt, xhr, status, error) ->
  if xhr.status == 403
    $('#edit-modal .error').html(xhr.responseText)
  else
    $('#edit-modal .error').html("An Error Occurred")

$('#edit-submit').click(() ->
  $('#edit-modal form').submit())

$('#edit-modal').on('ajax:success', 'form', editSuccess)
$('#edit-modal').on('ajax:error', 'form', editFailure)

