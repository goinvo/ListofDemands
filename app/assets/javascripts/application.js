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
//= require bootstrap.typeahead
//= require lodash
//= require @fengyuanchen/datepicker/dist/datepicker
//= require sortable
//= require_tree .

$.fn.slideFadeToggle  = function(speed, easing, callback) {
  return this.animate({opacity: 'toggle', height: 'toggle'}, speed, easing, callback);
};

$(function() {
  $(document).on('turbolinks:load', function() {
    var state = {
      navOpen: false
    };
    var breakpointDesktop = 800; // Should be equal to SCSS variable '$breakpoint-desktop'

    $('.alert-dismissible').fadeIn(200);

    $('.alert-dismiss-wrapper').click(function() {
      $(this).fadeOut();
    });

    setTimeout(function() {
      $('.alert-dismissible').fadeOut();
    }, 8000);

    $('.datepicker-input').datepicker();

    $('.typeahead').each(function(index, element) {
      var $element = $(element);
      $element.typeahead({source: $element.data().source, fitToElement: true})
    });

    function toggleHeader() {
      $('html').toggleClass('nav-open');
      $('#overlay').toggleClass('is-active');
      $('#navbar').toggleClass('is-open');
      $("#navbar-title").slideFadeToggle();
      $("#navbar-title-open").slideFadeToggle();
      $('#navbar-toggle .icon').toggle();
      state.navOpen = !state.navOpen;
    }

    // Set these back on load, because turbolinks keeps them when navigating
    $('html').removeClass('nav-open');
    state.navOpen = false;

    $('#navbar-toggle, #overlay').click(toggleHeader);

    $(window).resize(function() {
      if (state.navOpen && window.innerWidth > breakpointDesktop) {
        toggleHeader();
      }
    });
  });
});
