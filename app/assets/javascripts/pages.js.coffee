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
  $('#notice').html(data)
  $('#notice').show()
  if $('#notice .success').length > 0
    $('#split_amount').val('')
    $('#split_note').val('')


formFailure = (evt, xhr, status, error) ->
  $('#notice').html("An Error Occurred")
  $('#notice').show()

$('#new_split').bind('ajax:success', formSuccess)
$('#new_split').bind('ajax:error', formFailure)
