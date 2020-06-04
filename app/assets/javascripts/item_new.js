// ページ遷移後のfocusを画像選択にする動作
$(function() {
  $('.input-area').focus();
});

// 価格に応じて販売手数料と販売利益を表示する動作
$(function(){
  // 表示金額を変更する関数の定義
  function replaceFeeAndProfit(fee, profit) {
    $('#sell-fee').text(fee)
    $('#sell-profit').text(profit)
  }

  $("input[name='item[price]']").on('change keyup', function() {
  const price = $("input[name='item[price]']").val();
  let fee;
  let profit;
  if (!price){
    fee = '-'
    profit = '-'
  } else if (price >= 300 && price < 10000000) {
    const calc_fee = Math.floor(price * 0.1)
    const calc_profit = price - calc_fee

    fee = "¥" + String(calc_fee).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,'); 
    profit = "¥" + String(calc_profit).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,'); 
  } else {
    fee = '-'
    profit = '-'
  }
  replaceFeeAndProfit(fee, profit);
  }); 
});

// 配送方法の選択フィールドを追加表示する動作
$(function() {
  // 送料込み（出品者負担）の場合の配送方法の選択肢　→　ajax通信で取れるならとってきたい部分
  function sellerCharge() {
    const sellerChargeOptions =`
      <div class='field' id='seller-charge'>
        <div class='field__label'>
          <label for="item_delivery_method_id">配送の方法</label>
          <span class='field__label--require'>必須</span>
        </div>
        <div class='field__form item-area__field__form'>
          <select name="item[delivery_method_id]" id="item_delivery_method_id"><option value="">選択してください</option>
            <option value="1">未定</option>
            <option value="2">らくらくメルカリ便</option>
            <option value="3">ゆうゆうメルカリ便</option>
            <option value="4">ゆうメール</option>
            <option value="5">レターパック</option>
            <option value="6">普通郵便(定形、定形外)</option>
            <option value="7">クロネコヤマト</option>
            <option value="8">ゆうパック</option>
            <option value="9">クリックポスト</option>
            <option value="10">ゆうパケット</option>
          </select>
        </div>
      </div>
    `
    $('#delivery_charge').parent().append(sellerChargeOptions);
  }
  // 送料別（購入者負担）の場合の配送方法の選択肢 → ここもajax通信で取れるならとってきたい
  function buyerCharge() {
    const buyerChargeOptions = `
      <div class='field' id='buyer-charge'>
        <div class='field__label'>
          <label for="item_delivery_method_id">配送の方法</label>
          <span class='field__label--require'>必須</span>
        </div>
        <div class='field__form item-area__field__form'>
          <select name="item[delivery_method_id]" id="item_delivery_method_id"><option value="">選択してください</option>
            <option value="11">未定</option>
            <option value="12">クロネコヤマト</option>
            <option value="13">ゆうパック</option>
            <option value="14">ゆうメール</option>
          </select>
        </div>
      </div>
    `
    $('#delivery_charge').parent().append(buyerChargeOptions);
  }

  // 配送料の負担の選択に応じて、表示する内容を変更する動作
  $(document).on('change', '#item_delivery_charge_flag', function (){
    const sellerChargeMethod = $('#seller-charge')
    const buyerChargeMethod = $('#buyer-charge')  
    $("select[name='item[delivery_method_id]'] option").attr("selected", false);
    const chargeFlag = $(this).val();
    if (chargeFlag == "") {
      sellerChargeMethod.remove();
      buyerChargeMethod.remove();
    } else if (chargeFlag == 1) {
      sellerCharge();
      buyerChargeMethod.remove();
    } else {
      buyerCharge();
      sellerChargeMethod.remove();
    }
  });
});

// 入力フォームのバリデーション
$(function() {
  let value;
  let next;
  let priceNext;
  let imageNext;

  // blur時の動作
  function fieldBlur(input) {
    value = input.val();
    next = input.next();
    priceNext = input.parent().parent().next();
    // 未入力のチェック
    if (value == "") {
      if (!next.hasClass('error')) {
        input.addClass('error');
        if (input.is('select')) {
          input.after(`<p class='error'>選択してください</p>`);
        } else if (input.is('#sell-price-input') || input.is('.img-file')) {
          ;
        } else {
          input.after(`<p class='error'>入力してください</p>`)
        }
      }
    } else {
      input.removeClass('error');
      next.remove();
    }

    // 金額入力の入力チェック
    if (input.is('#sell-price-input')) {
      if (value == "" || value < 300 || value >= 10000000) {
        if (!priceNext.hasClass('error')) {
          input.parent().parent().after(`<p class='error price-error'>300以上10,000,000未満で入力してください</p>`);
        }
      } else if (priceNext.hasClass('error')) {
        priceNext.remove();
      } else {
        ;
      }
    }
  }
  // keyup時の動作
  function fieldKeyup(input) {
    value = input.val();
    next = input.next();
    priceNext = input.parent().parent().next();
    if (value != "") {
      input.removeClass('error');
      if (input.is('#sell-price-input')) {
        ;
      } else {
        next.remove();
      }
    }
    // 金額入力の入力チェック
    if (input.is('#sell-price-input')) {
      if (value >= 300 && value < 10000000) {
        if (priceNext.hasClass('error')) {
          priceNext.remove();
        }
      } else if (!priceNext.hasClass('error')) {
        input.parent().parent().after(`<p class='error price-error'>300以上10,000,000未満で入力してください</p>`);
      } else {
        ;
      }
    }
  }

  // 画像の入力チェック
  function imageCheck(num) {
    const imageNext = $('#image-box-1').next();
    if (num == 0) {
      if (!imageNext.hasClass('error')) {
        $('#image-box-1').after(`<p class='error'>画像がありません</p>`);
      }
    } else {
      if (imageNext.hasClass('error')) {
        imageNext.remove();
      }
    }
  }

  $('#new_item input:required').on('blur', function() {
    fieldBlur($(this));
  });

  $('#new_item input:required').on('keyup', function() {
    fieldKeyup($(this));
  });

  $('#new_item textarea').on('blur', function() {
    fieldBlur($(this));
  });

  $('#new_item textarea').on('keyup', function() {
    fieldKeyup($(this));
  });

  $('#new_item select').on('blur change', function() {
    fieldBlur($(this));
  });

  // 出品ボタン押下時の処理
  $('.item-form-btn').click(function(e) {
    e.preventDefault();
    const submitID = $(this).attr('id')
    let flag = true;
    const num = $('.item-image').length
    imageCheck(num);

    $('#new_item input:required').each(function(e) {
      if ($('#new_item input:required').eq(e).val() === "") {
        fieldBlur($('#new_item input:required').eq(e));
        flag = false;
      }
    });
    $('#new_item textarea:required').each(function(e) {
      if ($('#new_item textarea:required').eq(e).val() === "") {
        fieldBlur($('#new_item textarea:required').eq(e));
        flag = false;
      }
    });
    $('#new_item select').each(function(e) {
      if ($('#new_item select').eq(e).val() === "") {
        fieldBlur($('#new_item select').eq(e));
        flag = false;
      }
    });

    if (flag) {
      if (submitID == 'item-post-btn') {
        $("input[name='item[trading_status_id]']").val(1);
        $('#new_item').submit();
      } else {
        $("input[name='item[trading_status_id]']").val(4);
        $('#new_item').submit();
      }
    } else {
      $(this).off('submit');
      $('body,html').animate({ scrollTop: 0 }, 500);
      return false;
    }
  });
});


// 画像のプレビュー、ドラッグ等の処理に関する動作
$(function(){
  let imageNext;
  let fileIndex = 0;
  // 画像プレビュー関数
  function imagePreview(src, filename, i, num) {
    const html= `
      <div class='item-image add-image' data-image="${filename}" data-index-delete="${i}">
        <div class='item-image__content'>
          <div class='item-image__content--icon'>
            <img src=${src} width="114" height="80" index="${i}">
          </div>
        </div>
        <div class='item-image__operation'>
          <div class='item-image__operation--delete'>削除</div>
        </div>
      </div>
      `
    $('#image-box__container').before(html);
    $('#image-box__container').attr('class', `item-num-${num} drag-area`) 
  }

  // 画像追加時のエラーチェック関数
  function errorCheckOnAdd() {
    imageNext = $('#image-box-1').next();
    if (imageNext.hasClass('error')) {
      imageNext.remove();
    }
  }
  // 画像削除時のエラーチェック動作
  function errorCheckOnDel(num) {
    imageNext = $('#image-box-1').next();
    if (num == 0) {
      if (!imageNext.hasClass('error')) {
        $('#image-box-1').after(`<p class='error'>画像がありません</p>`);
      }  
    }
  }

  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  const file_field = document.querySelector('input[type=file]')

  //fileが選択された時に発火するイベント
  $(document).on('change', '.img-file', function(){
    errorCheckOnAdd();

    //選択したfileのオブジェクトをpropで取得
    const files = $('input[type="file"]').prop('files')[0];
    const currentNum = $('.item-image').length
    const add_files_length = this.files.length
    const inputNum = currentNum + add_files_length

    $.each(this.files, function(i, file){
      const fileReader = new FileReader();
      fileReader.readAsDataURL(file);
      const num = i

      
    //画像が10枚になったら超えたらドロップボックスを削除する
      if (num == 10){
        $('#image-box__container').css('display', 'none')
        fileReader.onloadend = function() {
          fileIndex += 1;
          const src = fileReader.result
          imagePreview(src, file.name, fileIndex, inputNum)
          dataBox.items.add(file)
          dataBox.items.remove(dataBox.items.length - 1);
          file_field.files = dataBox.files
        };  
        return false;      
      }
      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function() {
        fileIndex += 1;
        const src = fileReader.result
        imagePreview(src, file.name, fileIndex, inputNum)
        dataBox.items.add(file)
        $('input[type="file"]').val('');
        file_field.files = dataBox.files
      };
    });
  });

  // 画像ドラック時の動作
  $(window).on('load', function(e){
    const dropArea = document.getElementById("image-box-1");

    if (dropArea) {
      //ドラッグした要素がドロップターゲットの上にある時にイベントが発火
      dropArea.addEventListener("dragover", function(e){
        e.preventDefault();
        //ドロップエリアに影がつく
        $(this).children('.drag-area').css({'border': '1px solid rgb(204, 204, 204)','box-shadow': '0px 0px 4px'})
      },false);

      //ドラッグした要素がドロップターゲットから離れた時に発火するイベント
      dropArea.addEventListener("dragleave", function(e){
        e.preventDefault();
      //ドロップエリアの影が消える
        $(this).children('.drag-area').css({'border': 'none','box-shadow': '0px 0px 0px'})      
      },false);

      //ドラッグした要素をドロップした時に発火するイベント
      dropArea.addEventListener("drop", function(e) {

        e.preventDefault();
        $(this).children('.drag-area').css({'border': 'none','box-shadow': '0px 0px 0px'});

        errorCheckOnAdd();

        const files = e.dataTransfer.files;
        const add_files_length = files.length;

        //ドラッグアンドドロップで取得したデータについて、プレビューを表示
        $.each(files, function(i,file){
          const fileReader = new FileReader();
          fileReader.readAsDataURL(file);
          const inputNum = $('.item-image').length + add_files_length
          const num = i
          if (num==10){
            $('#image-box__container').css('display', 'none')
            fileReader.onloadend = function() {
              fileIndex += 1;
              const src = fileReader.result
              imagePreview(src, file.name, fileIndex, inputNum)
              dataBox.items.add(file)
              file_field.files = dataBox.files
            };  
            return false;
          }
          //image fileがロードされた時に発火するイベント
          fileReader.onloadend = function() {
            fileIndex += 1;
            const src = fileReader.result
            imagePreview(src, file.name, fileIndex, inputNum)
            dataBox.items.add(file)
            file_field.files = dataBox.files
          };
        })
      })
    }
  });
  //削除ボタンをクリック時の動作
  $(document).on("click", '.item-image__operation--delete', function(){
    //削除を押されたプレビュー要素を取得
    const target_image = $(this).parent().parent()
    //削除を押されたプレビューimageのindexを取得
    const targetIndex = $(target_image).data('index')
    const deleteIndex = $(target_image).data('index-delete') - 1;
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    const addImages = $('.add-image');
    let index = 0;
    if (addImages.length==1) {
      //inputタグに入ったファイルを削除
      $('input[type=file]').val(null)
      dataBox.clearData();
    } else {
      //プレビューが複数の場合
      $.each(addImages, function(i, input){
        //削除を押されたindexと一致した時、index番号に基づいてdataBoxに格納された要素を削除する
        if(i == deleteIndex) {
          dataBox.items.remove(deleteIndex)
        } else {
          index += 1
          $(input).attr('data-index-delete', index);
        }
      })
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に再度代入
      file_field.files = dataBox.files
    }
    //プレビューを削除
    target_image.remove()
    //image-box__containerクラスをもつdivタグのクラスを削除のたびに変更
    const num = $('.item-image').length
    $('#image-box__container').show()
    $('#image-box__container').attr('class', `item-num-${num} drag-area`)
    
    errorCheckOnDel(num);
  });
});