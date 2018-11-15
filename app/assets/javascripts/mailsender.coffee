# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  mailcheck_ajax_event()

mailcheck_ajax_event = ->
  $('#create_mail').on('ajax:success', (e) ->
      res = e.detail[0]
      switch res.result
        when "valid"
          $('#form_area').html(res.html)
          mailsend_ajax_event()
        else
          show_validation_error(res)
    ).on 'ajax:error', (e) ->
      alert("何らかの理由で処理を完了できませんでした。")

show_validation_error = (res) ->
  if res.errors['title']
    $('.m_title').addClass('is-danger') 
    $('#title > .field_with_errors > label')[0].innerText = res.errors['title']
  else
    $('.m_title').removeClass('is-danger') 
    $('#title > .field_with_errors > label')[0].innerText = ''
  if res.errors['content']
    $('.m_content').addClass('is-danger') 
    $('#content > .field_with_errors > label')[0].innerText = res.errors['content']
  else
    $('.m_content').removeClass('is-danger') 
    $('#content > .field_with_errors > label')[0].innerText = ''

mailsend_ajax_event = ->
  $('#check_mail').on('ajax:success', (e) ->
    res = e.detail[0]
    # console.log res
    switch res.result
      when "re_edit"
        $('#form_area').html(res.html)
        mailcheck_ajax_event()
  ).on 'ajax:error', (e) ->
    alert("何らかの理由で処理を完了できませんでした。")