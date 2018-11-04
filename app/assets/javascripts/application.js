// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery-ui/widgets/datepicker
//= require jquery-ui/i18n/datepicker-ja
//= require rails-ujs
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $(".notification button.delete").click(function() {
    $(this).parent().remove();
  }); 

  $('tr[data-href]').addClass('clickable').click(function(e) {
    if(!$(e.target).is('a')){
      window.location = $(e.target).closest('tr').data('href');
    }
  });

  $('.navbar-burger').click(function() {
    $('.navbar-menu').toggle('is-active');
  });

  dateFormat = 'yy-mm-dd';
  $('.date-picker').datepicker({
    dateFormat: dateFormat,
    changeYear: true,
    changeMonth: true
  });

  $('.modal button.delete').click(function () {
    $('.modal').removeClass('is-active');
  });
  $('.modal-card a.button.is-success').click(function () {
    $('.modal').removeClass('is-active');
  })
  $('button.join-modal').click(function(){
    $('.modal').addClass('is-active');
  });
  $()
  $('.modal .modal-background').click(function(){
    $('.modal').removeClass('is-active');
  });
  $('a#pre-input').click(function () {
    $('textarea')[1].value = "## イベント内容\n\n## 集合場所\n\n## 持ち物\n\n"
  });
 });

var timer = false;
$(window).resize(function() {
    if (timer !== false) {
        clearTimeout(timer);
    }
    timer = setTimeout(function() {
        if($(window).width() >= 1088){
          $('.navbar-menu').removeAttr('style')
        }
    }, 200);
});