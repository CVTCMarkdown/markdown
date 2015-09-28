# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
source = '#markdown'
target = '#compiled'

pageLoadHandler = ->
    $(target).html marked $(source).val()
    
    
$(document).on 'page:load', pageLoadHandler
$(document).ready pageLoadHandler