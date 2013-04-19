# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

refreshUserSummary = () ->
  if $('#user-summary').length
    $.ajax({
      url: $('#user-summary').data('id') + '/summary',
      success: (data, status, xhr) ->
        $('.total').html(data.total)
        $('#user-summary').html(data.summary)
    })

$('#notifications, #user-summary').on('ajax:success', '.refresh-trigger', refreshUserSummary)
$('#edit-modal').on('ajax:success', 'form', refreshUserSummary)
$('#new_transaction').on('ajax:success', refreshUserSummary)
