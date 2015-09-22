# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

event = 'keyup'
body = 'body'
source = '#note_markdown'
target = '#compiled'

attachMarkdownChangedHandler = ->
    $(source).on event, ->
        $(target).html marked $(source).val()
    .trigger event
    
$(document).on 'page:load', attachMarkdownChangedHandler
$(document).ready attachMarkdownChangedHandler
