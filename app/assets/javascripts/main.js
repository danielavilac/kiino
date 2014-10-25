$( document ).ready(function(){
  resize();
  $(document).ready(function() {
    $('#fullpage').fullpage();
  });
  $( window ).resize(function() {
    resize();
  });  
});

function resize() {
  // $('main').height($(window).height());
  // $('.main-search').css("margin-top", ($(document).height()/2) - $('.main-search').height()/2)
  $('.main-search').focus();
  $('.main-search').select();
  if ( $('.tumblr-1').length ) {
    $('.tumblr-1').height($(window).height() * .20);
  }
  if ( $('.tumblr-4').length ) {
    $('.tumblr-4').height($(window).height() * .40);
  }
}
