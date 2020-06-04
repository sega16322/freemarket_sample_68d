$(function(){
  $(document).on('change', '#account_icon_image', function () {
    const file = this.files[0];
    const fileReader = new FileReader();
    fileReader.readAsDataURL(file);
    fileReader.onload = function () {
      const image = this.result;
      $('.account__image__form__icon').attr({ src: image });
      $('.user__mypage--icon').attr({ src: image });
      $('.user__mypage--big--icon').attr({ src: image });
    }
  });
  $(document).on('change',  '#account_background_image', function () {
    const file = this.files[0];
    const fileReader = new FileReader();
    fileReader.readAsDataURL(file);
    fileReader.onload = function () {
      const image = this.result;
      $('.account__image__form__background').attr({ src: image });
      $('.mypage__background').attr({ src: image });
    }
  });
});