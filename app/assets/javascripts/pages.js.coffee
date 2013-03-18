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

refreshSummary = () ->
  $.ajax({
    url:'summary',
    success: (data, status, xhr) ->
      $('.summary').html(data)
  })


formSuccess = (evt, data, status, xhr) ->
  showAlert(data)
  if data.indexOf('alert-success') >= 0
    $('#split_amount').val('')
    $('#split_note').val('')
    refreshSummary()

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

handleApproval = (evt, data, status, xhr) ->
  $('#approval-flag').html(data)
  refreshSummary()

$('#new_split').bind('ajax:success', formSuccess)
$('#new_split').bind('ajax:error', formFailure)

$('#approve').bind('ajax:success', handleApproval)
$('#reject').bind('ajax:success', handleApproval)
