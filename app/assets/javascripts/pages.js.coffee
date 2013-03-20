# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$('#split_with').tokenInput("/friends",{
  theme:'facebook',
  preventDuplicates:true,
  onReady: () ->
    $('#token-input-split_with').attr('placeholder', $('#split_with').attr('placeholder'))
  onAdd: (item) ->
    $('#token-input-split_with').attr('placeholder', '')
});

formSuccess = (evt, data, status, xhr) ->
  showAlert(data)
  if data.indexOf('alert-success') >= 0
    $('#split_amount').val('')
    $('#split_note').val('')

formFailure = (evt, xhr, status, error) ->
  data = "
    <div class='alert alert-error'>
      <button type='button' class='close'>&times;</button>
      An Error Occurred
    </div>"
  showAlert(data)

showAlert = (data) ->
  $('#alert-container').slideUp()
    .queue( (e) ->
      $(this).html(data)
      e()
    ).slideDown().queue( (e) ->
      $('#alert-container button.close').click(() ->
        $('#alert-container').slideUp()
      )
      e()
    )

$('#new_split').bind('ajax:success', formSuccess)
$('#new_split').bind('ajax:error', formFailure)

refreshSummary = () ->
  $.ajax({
    url:'summary',
    success: (data, status, xhr) ->
      $('.summary').html(data)
  })

refreshNotifications = (evt, data, status, xhr) ->
  $('#notifications').html(data)
  $('#notifications .refresh-trigger').bind('ajax:success', refreshNotifications)
  refreshSummary()

$('#notifications .refresh-trigger').bind('ajax:success', refreshNotifications)

editSuccess = (evt, data, status, xhr) ->
  refreshNotifications(evt, data, status, xhr)
  $('#edit-modal').modal('hide')

editFailure = (evt, xhr, status, error) ->
  if xhr.status == 403
    $('#edit-modal .error').html(xhr.responseText)
  else
    $('#edit-modal .error').html("An Error Occurred")


$('#edit-submit').click(() ->
  $('#edit-modal form').bind('ajax:success', editSuccess)
  $('#edit-modal form').bind('ajax:error', editFailure)
  $('#edit-modal form').submit())
