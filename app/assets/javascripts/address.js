$(function(){
  //郵便番号を入力することで住所自動入力
  $("#address_postal_code").jpostal({
    postcode : [ "#address_postal_code" ],
    address  : {
                  "#address_prefectures" : "%3",
                  "#address_municipality": "%4",
                  "#address_address"     : "%5%6%7"
                }
  });

  function errorCheck(input, regex, format){
    const pattern = regex;
    const Regex = input.val().match(pattern);
    const next = input.next();
    if(Regex == null){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        input.css("border", "1px solid red");
        input.after(`<div class=error-class2>${format}</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&& input.hasClass("error-class")){
        input.css("border", "1px solid red");
        input.after(`<div class=error-class2>${format}</div>`);
      }else{
        input.css("border", "1px solid red");
      }  
    }else{
      input.css("border", "1px solid #00BFFF");
      next.remove();
    }
  }

  function errorCheck2(input, regex, format){
    const pattern = regex;
    const value = input.val();
    const next = input.next();
    if(value === "" || value.match(pattern) != null) {
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        input.css("border", "1px solid red");
        input.after(`<div class=error-class2>${format}</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&& input.hasClass("error-class")){
        input.css("border", "1px solid red");
        input.after(`<div class=error-class2>${format}</div>`);
      }else{
        input.css("border", "1px solid red");
      }  
    }else{
      input.css("border", "1px solid #00BFFF")
      next.remove();
    }
  }

  function errorCheck3(input, regex, format){
    const pattern = regex;
    const value = input.val();
    const next = input.next();
    if(value != "" && value.match(pattern) == null) {
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        input.css("border", "1px solid red");
        input.after(`<div class=error-class2>${format}</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&& input.hasClass("error-class")){
        input.css("border", "1px solid red");
        input.after(`<div class=error-class2>${format}</div>`);
      }else{
        input.css("border", "1px solid red");
      }  
    }else{
      input.css("border", "1px solid #00BFFF")
      next.remove();
    }
  }
  

  //郵便番号
  $("#address_postal_code").keyup(function(){
    errorCheck($(this),  /^[0-9]{7}$/, "郵便番号を入力してください");
  });

  //市区町村
  $("#address_municipality").keyup(function(){
    errorCheck2($(this), /[ |　]+/, "市区町村を入力してください");
  });

  //番地
  $("#address_address").keyup(function(){
    errorCheck2($(this), /[ |　]+/, "番地を入力してください");
  });

  //電話番号
  $("#address_phone_number").keyup(function(){
    errorCheck3($(this), /^(0{1}\d{9,10})$/, "電話番号を入力してください");
  });

  //建物名
  $("#address_building").keyup(function(){
    const pattern = /[ |　]+/;
    const value = $(this).val();
    const next = $(this).next();
    if(value != "" && value.match(pattern) != null) {
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>建物名・部屋番号を入力してください</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>建物名・部屋番号を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }  
    }else{
      $(this).css("border", "1px solid #00BFFF")
      next.remove();
    }
  });

  //都道府県
  $('#address_prefectures').on("change", function(){
    const prefectures = $(this).val();
    const next = $(this).next();
    if(prefectures === ""){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>都道府県を入力してください</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove(".error-class2");
    }
  });
  
  //発送元・お届け先住所変更時のバリデーションチェック

  $('.change__address__btn').click(function(e) {
    e.preventDefault();
    let flag = true;
    const pattern = /^(0{1}\d{9,10})$/;
    const phone_number = $("#address_phone_number").val()
    if($(".error-class2").length){
      flag = false;
    }
    if(phone_number != "" && phone_number.match(pattern) == null){
      flag = false;
    }
    $('#edit_address input:required').each(function(e) {
      if ($('#edit_address input:required').eq(e).val() === "") {
        flag = false;
      }
    });
    $('#edit_address textarea:required').each(function(e) {
      if ($('#edit_address textarea:required').eq(e).val() === "") {
        flag = false;
      }
    });
    $('#edit_address select').each(function(e) {
      if ($('#edit_address select').eq(e).val() === "") {
        flag = false;
      }
    });
    
    if (flag) {
      $('#edit_address').submit();
    } else {
      const errorInput = $(".error-class2:first").prev();
      const position = errorInput.offset().top - 40;
      const speed = 400;
      $(this).off('submit');
      $('body,html').animate({scrollTop:position}, speed, 'swing');
      errorInput.focus();
      return false;
    }
  });
});
