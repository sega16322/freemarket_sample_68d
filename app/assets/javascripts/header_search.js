$(function() {
  $('.header__block__inner__form__box__input').on('focus', function() {
    $(this).parent().css({'border': '1px solid skyblue'});
  })
  $('.header__block__inner__form__box__input').on('click', function() {
    $(this).parent().css({'border': '1px solid skyblue'});
  })
  $('.header__block__inner__form__box__input').on('blur', function() {
    $(this).parent().css('border', '1px solid lightgray');
  })
});