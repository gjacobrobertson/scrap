# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

formSuccess = (evt, data, status, xhr) ->
  showAlert(data)
  $('#split_amount').val('')
  $('#split_note').val('')

formFailure = (evt, xhr, status, error) ->
  if xhr.status = 403
    showAlert(xhr.responseText)
  else
    showAlert( "
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

$('#new_split').on('ajax:success', formSuccess)
$('#new_split').on('ajax:error', formFailure)

$('#split_with').tokenInput("/friends",{
  theme:'facebook',
  preventDuplicates:true,
  onReady: () ->
    $('#token-input-split_with').attr('placeholder', $('#split_with').attr('placeholder'))
  onAdd: (item) ->
    $('#token-input-split_with').attr('placeholder', '')
});
