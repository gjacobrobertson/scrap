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

$('#new_transaction button').click(() ->
  $('#new_transaction').submit())

formSuccess = (evt, data, success, xhr) ->
  showAlert(data)
  $('#transaction_amount').val('')

formFailure = (evt, xhr, status, error) ->
  if xhr.status = 403
    showAlert(xhr.responseText)
  else
    showAlert ( "
      <div class='alert alert-error'>
        <button type='button' class='close'>&times;</button>
        An Error Occurred
      </div>")

showAlert = (data) ->
  if $('#alert-container').is(":visible")
    $('#alert-container').slideUp()
  $('#alert-container').queue( (e) ->
      $(this).html(data)
      e())
    .slideDown()
    .queue( (e) ->
      $('#alert-container button.close').click(() ->
        $('#alert-container').slideUp()
      )
      e()
    )

$('#new_transaction').on('ajax:success', formSuccess)
$('#new_transaction').on('ajax:error', formFailure)
