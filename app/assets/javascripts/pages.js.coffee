# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

refreshSummary = () ->
  if $('.summary').length
    $.ajax({
      url:'summary',
      success: (data, status, xhr) ->
        $('.summary').html(data)
    })

$('#new_split').on('ajax:success', refreshSummary)
$('#notifications').on('ajax:success', '.refresh-trigger', refreshSummary)
$('#edit-modal').on('ajax:success', 'form', refreshSummary)
