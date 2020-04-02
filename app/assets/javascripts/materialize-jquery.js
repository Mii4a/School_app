var content = $("div.col");
var sidebar = $("aside.col");
var smWindowSize = 600;

function materializeConvertClass(target, removeClass, addClass){
  $(target).removeClass(removeClass).addClass(addClass);
}

$(document).on('turbolinks:load', function(){
  // sidenavの表示
  $(".sidenav").sidenav();

  // dropdown-menuの表示
  $(".dropdown-trigger").dropdown();

  // modalの表示
  $('.modal').modal();
});

// eventの初期化
$(document).on("turbolinks:before-cache", function () {
  $('.sidenav').sidenav('destroy');
  $('.dropdown-trigger').dropdown('destroy');
  $('.modal').modal('destroy');
});

// ウィンドウ幅600px以下にresizeした場合col.12に置き換える
$(window).on("resize", function(){
  content = $("div.col");
  sidebar = $("aside.col");
  if (window.innerWidth <=  smWindowSize){
    materializeConvertClass(content, "s8", "s12");
    materializeConvertClass(sidebar, "s4", "s12");
  } else {
    materializeConvertClass(content, "s12", "s8");
    materializeConvertClass(sidebar, "s12", "s4");
  }
});

