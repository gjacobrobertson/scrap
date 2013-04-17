# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
refreshSummary = () ->
  if $('.summary').length
    $.ajax({
      url:'summary',
      success: (data, status, xhr) ->
        $('.summary').html(data)
    })

$('#new_split').on('ajax:success', refreshSummary)
$('#notifications .refresh-trigger').on('ajax:success', refreshSummary)

refreshNotifications = (evt, data, status, xhr) ->
  $('#notifications').html(data)
  $('#notifications .refresh-trigger').bind('ajax:success', refreshNotifications)

editSuccess = (evt, data, status, xhr) ->
  refreshNotifications(evt, data, status, xhr)
  $('#edit-modal').modal('hide')

editFailure = (evt, xhr, status, error) ->
  if xhr.status == 403
    $('#edit-modal .error').html(xhr.responseText)
  else
    $('#edit-modal .error').html("An Error Occurred")

$('#notifications .refresh-trigger').bind('ajax:success', refreshNotifications)

$('#edit-submit').click(() ->
  $('#edit-modal form').bind('ajax:success', editSuccess)
  $('#edit-modal form').bind('ajax:error', editFailure)
  $('#edit-modal form').submit())
