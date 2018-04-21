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
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){

  var w = 0;
  var h = 0;
  var login_cw = 0;
  var login_ch = 0;
  var register_cw = 0;
  var register_ch = 0;
  var login_pxleft = 0;
  var login_pxtop = 0;
  var register_pxleft = 0;
  var register_pxtop = 0;

  var displayCalc = 0;

  // Read all products to display
  ajax();

  // Modal form for login
  $('#login-button').on("click",function(){
    loginForm();
  });

  // Modal form for register
  $('#register-button').on("click",function(){
    // スクロールバーの横幅を取得
    // $('html').append('<div class="scrollbar" style="overflow:scroll;"></div>');
    // var scrollsize = window.innerWidth - $('.scrollbar').prop('clientWidth');
    // $('.scrollbar').hide();
    // $('html, body').addClass('lock');
    registerForm();
  });

  // To close modal
  $("#modal-overlay").click(function(){
    $("#modal-overlay").fadeOut("slow");
    $('#login-modal').fadeOut("slow");
    $('#register-modal').fadeOut("slow");
  });

  // To move register form from login form
  $('#create-btn').click(function(){
    // $("#modal-overlay").fadeOut("slow");
    $('#login-modal').fadeOut("slow");
    registerForm();
  });

  $('#login-link').click(function(){
    $('#register-modal').fadeOut("slow");
    loginForm();
  });


  $('.category-menu').click(function(){
    // ajax function needs one argument to pass the controller and to get data from database
    ajax($(this).attr('id'));
  });

  $('#all').click(function(){
    // ajax function needs one argument, so write "" and pass to avoid unexpected error
    ajax("");
  });

  $(window).resize(centeringModalSyncer);

  function ajax(id) {
    $.ajax({
      url: "/",
      type: "GET",
      dataType: "JSON",
      // if you want to pass the data to controller, write params[:id] in the controller
      data: { id: id },

      error:function(error){
        console.log(error);
      },

      success:function(data){
        // for initialize
        $('.items-wrapper').html("").fadeOut();
        console.log(data);
        $.each(data,function(key,value){
          console.log(value.img_name.url);
          var pro = "<div class='col-md-2'>";
          pro += "<a href='/products/"+value.id+"'>";
          pro += "<img src="+value.img_name.url+" style='width:150px; height:150px'>";
          pro += "</a>";
          pro += "<p>"+value.name+"</p>";
          pro += "<h6>Rs"+value.price+"</h6>";
          pro += "<h6>#"+value.category_id+"</h6>";
          pro += "</div>";
          $('.items-wrapper').append(pro).fadeIn();
        });
      }
    });
  }

  function loginForm() {
    $(this).blur();
    if($('.modal-overlay')[0]) return false;
    // if($("#modal-overlay")[0]) $("#modal-overlay").remove();
    // $('body').append('<div id="modal-overlay"></div>');
    // $('body').append('<div id="login-modal"></div>');

    centeringModalSyncer()

    $('#modal-overlay').fadeIn('slow');
    $('#login-modal').fadeIn('slow');
  }

  function registerForm() {
    $(this).blur();
    if($('.modal-overlay')[0]) return false;
    // if($("#modal-overlay")[0]) $("#modal-overlay").remove();
    // $('body').append('<div id="modal-overlay"></div>');

    centeringModalSyncer()

    $('#modal-overlay').fadeIn('slow');
    $('#register-modal').fadeIn('slow');
  }

  function centeringModalSyncer(){
    // displayCalc is to avoid bug when push login or register twice
    // if (displayCalc === 0){
      w = $(window).width();
      h = $(window).height();
      login_cw = $("#login-modal").outerWidth();   // Get content width
      login_ch = $("#login-modal").outerHeight();  // Get content height
      login_pxleft = ((w - login_cw)/2);
      login_pxtop = ((h - login_ch)/2);
      register_cw = $('#register-modal').outerWidth();
      register_ch = $('#register-modal').outerHeight();
      register_pxleft = ((w - register_cw)/2);
      register_pxtop = ((h - register_ch)/2);
      $("#login-modal").css({"left": login_pxleft + "px"});
      $("#login-modal").css({"top": login_pxtop + "px"});
      $("#register-modal").css({"left": register_pxleft + "px"});
      $("#register-modal").css({"top": register_pxtop + "px"});

      // displayCalc = 1;
    // }
  }

});
