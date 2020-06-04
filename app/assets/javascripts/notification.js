$(function()  {
  $(".header__right--content--menu.news__content--link.drop--notice").hover(function() {
    $(".notice__news__box").not(":animated").slideDown();
  },function(){
    $(".notice__news__box").slideUp();
  });
});