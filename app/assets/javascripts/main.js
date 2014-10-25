$( document ).ready(function(){
  resize();
  $( window ).resize(function() {
    resize();
  });  
});

function resize() {
  $('main').height($(window).height());
  $('.main-search').css("margin-top", ($(document).height()/2) - $('.main-search').height()/2)
  $('.main-search').focus();
  $('.main-search').select();
}
