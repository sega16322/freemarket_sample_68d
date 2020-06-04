$(function() {
  // パスワードチェックボックス
  $("#checkpw").change(function(){
    if($(this).prop('checked')){
      $('#user_password').attr('type','text');
      $('#user_password_confirmation').attr('type','text');
    }else{
      $('#user_password').attr('type','password');
      $('#user_password_confirmation').attr('type','password');
    }
  });

  // 新規登録エラー

  function errorCheck(input, regex, format){
    const pattern = regex;
    const Regex = input.val().match(pattern);
    const next = input.next();
    if(Regex == null){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        input.css("border", "1px solid red");
        input.after(`<div class=error-class2>${format}</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&input.hasClass("error-class")){
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
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2") && input.hasClass("error-class")){
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

  //ニックネーム
  $("#user_nickname").keyup(function(){
    errorCheck2($(this), /[ |　]+/, "ニックネームを入力してください")
  });

  //Eメール
  $('#user_email').keyup(function(){
    errorCheck($(this), /[\x21-\x3f\x41-\x7e]+@(?:[-a-z0-9]+\.)+[a-z]{2,}/, "フォーマットが正しくありません");
  });

  //パスワード
  $("#user_password").keyup(function(){
    errorCheck($(this), /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}$/, "フォーマットが正しくありません");
  });

  //現在のパスワード
  $("#user_current_password").keyup(function(){
    errorCheck($(this), /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}$/, "フォーマットが正しくありません");
  });

  //パスワード再入力
  $("#user_password_confirmation").keyup(function(){
    const password = $("#user_password").val();
    const next = $(this).next();
    if($(this).val() != password){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>パスワードが一致しません</div>`);
      }else if(!next.hasClass("error-class") && !next.hasClass("error-class2")&&$(this).hasClass("error-class")){
        $(this).css("border", "1px solid red");
        $(this).after(`<div class=error-class2>パスワードが一致しません</div>`);
      }else{
        $(this).css("border", "1px solid red");
      }
      
    }else{
      $(this).css("border", "1px solid #00BFFF");
      next.remove();
    }
  });

  const first_name = $('[id$=first_name]');
  const last_name = $('[id$=last_name]');
  const first_name_kana = $('[id$=first_name_kana]');
  const last_name_kana = $('[id$=last_name_kana]');
  //姓（全角）
  $(last_name).keyup(function(){
    errorCheck($(this), /^[ぁ-んァ-ン一-龥]/, "姓（全角）を入力してください");
  });

  //名（全角）
  $(first_name).keyup(function(){
    errorCheck($(this), /^[ぁ-んァ-ン一-龥]/, "名（全角）を入力してください");
  });

  //姓（カナ）
  $(last_name_kana).keyup(function(){
    errorCheck($(this),  /^[ァ-ヶー－]/, "姓（カナ）を入力してください");
  });

  //名（カナ）
  $(first_name_kana).keyup(function(){
    errorCheck($(this),  /^[ァ-ヶー－]/, "名（カナ）を入力してください");
  });

  //生年月日
  $(".field__birthday > select").on("change", function(){
    const year  = $("#user_birthday_1i").val();
    const month = $("#user_birthday_2i").val();
    const day   = $("#user_birthday_3i").val();
    const next  = $("#user_birthday_3i").next();
    const value = $(this).val();
    if(value != ""){
      $(this).css("border", "1px solid #00BFFF");
    }else{
      $(this).css("border", "1px solid red");
    }
    if(year === "" || day === "" || month === ""){
      if(!next.hasClass("error-class") && !next.hasClass("error-class2")){
        $("#user_birthday_3i").after(`<div class=error-class2>生年月日を入力してください</div>`);
      }
    }else {
      next.remove(".error-class2");
      next.remove(".error-class");
    }
  });
  //画面遷移しようとした際バリデーションに引っかかった場合
  const next = $("#user_birthday_3i").next();
  if(next.hasClass("error-class")){
    $("select").css("border", "1px solid red");
    $("#user_birthday_1i").css("border", "1px solid red");
    $("#user_birthday_2i").css("border", "1px solid red");
    $("#user_birthday_3i").css("border", "1px solid red");
  }
});

