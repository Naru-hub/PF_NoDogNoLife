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
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require jquery

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
/*global $*/

// Aboutページ
$(function () {
  $(window).scroll(function () {
    $('.animationTarget').each(function () {
      //ターゲットの位置を取得
      const targetElement = $(this).offset().top;
      //スクロール量を取得
      const scroll = $(window).scrollTop();
      //ウィンドウの高さを取得
      const windowHeight = $(window).height();
      // ターゲットまでスクロールするとフェードインする
      if (scroll - 250 > targetElement - windowHeight){
        //クラスを付与
        $(this).addClass('view');
      }
    });
  });
});

// フラッシュメッセージ
$(function(){
  $('.alert').fadeOut(4000);  //4秒かけて消えていく
});