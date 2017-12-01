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
//
//= require jquery
//= require jquery-ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap.typeahead
//= require lodash
//= require datepicker
//= require sortable
//= require_tree .

$(function() {
  $(document).on('turbolinks:load', function() {
    setTimeout(function() {
      $('.alert-dismissible').fadeOut();
    }, 3000);

    $('.datepicker-input').datepicker();

    $('.typeahead').each(function(index, element) {
      var $element = $(element)
      $element.typeahead({source: $element.data().source})
    });
  });
});