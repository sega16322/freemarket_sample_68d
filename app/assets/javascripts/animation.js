$(window).scroll(function (){
  $('.pickup-box').each(function(){
    var position = $(this).offset().top;
    var scroll = $(window).scrollTop();
    var windowHeight = $(window).height();
    if (scroll > position - windowHeight + 100){
      $(this).addClass('active');
    }
  });
});
$(function(){
  function inputFocus() {
    if($('input').hasClass("error-class")){
      $(".error-class:first").focus();
      $("input[class=error-class]").css("border", "1px solid red");
    }else{
      $('input[type=text]:first').focus();
    }
    $('input').on("keydown", function(e) {
      const sumInput = $("input").length;
      if (e.which == 13){
        e.preventDefault();
        const nextIndex = $('input').index(this) + 1;
        if(nextIndex < sumInput) {
          $('input')[nextIndex].focus();
        }
      }
    });
  }
  if (document.location.href.match(/\/users\/sign_up$/) || document.location.href.match(/\/users$/)|| document.location.href.match(/\/addresses$/) || document.location.href.match(/\/users\/sign_in$/)) {
    inputFocus();
  }
  $('#edit_user').on("keydown", function(e) {
    const n = $("input").length;
    if (e.which == 13){
      e.preventDefault();
      const nextIndex = $('input').index(this) + 1;
      if(nextIndex < n) {
          $('input')[nextIndex].focus();
      }
    }
  });
  function scrollTopMessage(){
    $('#trading__messages').animate({ scrollTop: $('#trading__messages')[0].scrollHeight});
  } 
  $("#message-send-btn").on('click', function(){
    scrollTopMessage();
  });
  if (document.location.href.match(/\/items\/\d+\/trading\/\d+/)) {
    scrollTopMessage();
  }
})