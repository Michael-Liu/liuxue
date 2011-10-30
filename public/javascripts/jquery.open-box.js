/**
 * author @myliang
 * datetime 2010-05-21 03:30:00
 * popup
 **/
(function($){
  function page_height(){
    if (document.documentElement && document.documentElement.clientHeight)
      return document.documentElement.clientHeight; 
    else if (document.body)
      return document.body.clientHeight;
  };
  function open_box(opts){
    $.extend(true, this, open_box.settings, opts || {});
    this.box = $(
      ['<div id="open-box">',
         '<div class="o-popup">',
           '<div class="o-content">',
             '<h2>', this.title, '</h2>',
             '<div id="m-inner-content" class="o-inner"></div>',
           '</div>',
           '<a id="m-close" href="javascript:void(0);" class="o-close">',
             '×',
           '</a>',
         '</div>',
       '</div>'].join(''));
    this.main_content = $('#m-inner-content', this.box);
    this.a_close = $('#m-close', this.box);

    this.init();
  }; 

  open_box.settings = {
    width: 400,
    height: 200,
    title: 'Title',
    content: 'Content'
  };

  open_box.prototype = {
    init: function(){
      this.main_content.html(this.content);
      var off = this.offset();

      this.box.css({'width': this.width, 'left': off.left, 'top': off.top});
      $('body').append(this.box);

      this.handle_event();
    },
    offset: function(){
      var scrollTop = $(document).scrollTop();
      var top = (page_height() - this.height)/4;
      top += scrollTop;
      //alert(scrollTop)
      if(top <= 0 ) top = 10;
      var left = ($(document.body).width() - this.width)/2;
      //alert(this.height + ':::' + left + ':::::' + top)
      return {left: left, top: top};
    },
    handle_event: function(){
      var self = this;

      $(window).keydown(function(e){
        e = window.event || e;    
        if(e.keyCode == 27)
          self.close();
      });
      this.a_close.click(function(){
        self.close();    
      });              

      //设置texarea focus
      $('textarea', this.box).each(function(){
        var length = $(this).val().length;
        $m.textarea_select(this, length, length);
      });
    },
    close: function(){
      this.box.remove();
    }
  };

  var instance = {
    el: null,
    exist: function(callback){
      if(this.el == null){
        this.el = callback();
      }else{
        this.el.close();
        this.el = null;
      }
    }
  };

  $.box = function(opts){
    instance.exist(function(){
      return new open_box(opts);
    })
  };
  $.box.close = function(){
    $('#open-box').hide();
  };

  $.fn.box = function(opts){
    this.each(function(){ 
      instance.exist(function(){
        opts.content = $(this).html();
        return new open_box(opts); 
      });
    });
  };
})(jQuery);
