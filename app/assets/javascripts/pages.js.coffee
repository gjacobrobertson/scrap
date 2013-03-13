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
  if $('#alert-container .alert-success').length > 0
    $('#split_amount').val('')
    $('#split_note').val('')


formFailure = (evt, xhr, status, error) ->
  $('#alert-container').html("An Error Occurred")
  $('#alert-container').show()

$('#new_split').bind('ajax:success', formSuccess)
$('#new_split').bind('ajax:error', formFailure)
