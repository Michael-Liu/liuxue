/**
 * window.event.cancelBubble   => ie
 * return false || event.stopPropageation() => firefox
 * (event || window.event).keyCode => ie firefox
 */
$.extend(String.prototype, {
  to_obj: function(){
    return eval('(' + this + ')');
  }    
});
$.extend(Array.prototype, {
  to_str: function() {
    return this.join('');
  },
  rm: function(v){
    var slf = this;
    this.each(function(ele, index){
      if(v == ele) slf.splice(index, 1);
    });
  },
  map: function(callback) {
    var b = [];
    this.each(function(element, i) {
      b.push(callback(element, i));
    });
    return b;
  },
  find: function(callback){
    for( var i = 0; i < this.length; i++) if(callback(this[i], i)) return this[i];
    return null;
  },
  each: function(callback) {
    for (var i = 0; i < this.length; i++) callback(this[i], i);
  }
});

/**************************************** jquery pagination *************************************/
(function(){
  function pagination(el, opts){
    this.pg = $(el);
    $.extend(this, pagination.settings, opts || {});
    this.rows = parseInt(this.rows);
    this.init();
  }

  pagination.settings = {
    position: 'bottom',  // 'bottom' or 'top'
    prev: null,          // 
    next: null,
    first: null,
    last: null,
    click_after: function(type, after_func){ after_func(); },
    current: null,
    c_page: 1,
    pages: 1,
    rows: 0,
    page_rows: 6,
    syn: true
  };

  pagination.prototype = {
    init: function(){
      this._before();
      this.loading();
      this.syn && this._after();
    },
    event_mouse: function(){
      var slf = this;
      this.prev.click(function(){ 
        slf.c_page--;    
        slf._click_after();
      });             
      this.first.click(function(){ 
        slf.c_page = 1;    
        slf._click_after();
      });             
      this.next.click(function(){ 
        slf.c_page++;
        slf._click_after();
      });             
      this.last.click(function(){ 
        slf.c_page = slf.pages;
        slf._click_after();
      });             
    },
    _click_after: function(){
      var slf = this;
      this.click_after({index: this.c_page, size: this.page_rows}, function(){ slf._after(); });
    },
    loading: function(){
      this.pg.html(
          ['<div class="pagination">',
          this._total(),
          this._span('disabled', '首页'),
          this._span('disabled', '上页'),
          '<span class="current loading">&nbsp;&nbsp;loading...&nbsp;&nbsp;</span>',
          this._span('disabled', '下页'),
          this._span('disabled', '末页'),
          '</div>'].to_str());         
    },
    /** s_c_page(index){
      this._c_page = index;
      this._after();
    },**/
    _before: function(){
      this.pages = this.rows == 0 ? this.pages : parseInt(this.rows / this.page_rows);
      if(parseInt(this.rows % this.page_rows) > 0) this.pages++;
    },
    _after: function(){
      this.pg.html(this._div());

      this.prev = $('a.prev', this.pg); 
      this.first = $('a.first', this.pg);
      this.next = $('a.next', this.pg);
      this.last = $('a.last', this.pg);
      this.current = $($('a.current', this.pg)[1]);

      this.event_mouse();
    },
    _div: function(){
      return ['<div class="pagination ', this.position ,'">', 
        this._total(), this._first(), this._prev(), this._current(), this._next(), this._last(), 
        '</div>'].to_str();      
    },
    _current: function(){
      return this._span('current', this.c_page);         
    },
    _total: function(){
      return this._span('current', this.rows);       
    },
    _first: function(){
      return this._prev_('first', '首页');
    },
    _prev: function(){
      return this._prev_('prev', '上页');       
    },
    _last: function(){
      return this._next_('last', '末页');
    },
    _next: function(){
      return this._next_('next', '下页');
    },
    _prev_: function(cls, txt){
      if(this.c_page == 1) return this._span('disabled', txt);        
      return this._a(cls, txt);
    },
    _next_: function(cls, txt){
      if(this.c_page == this.pages) return this._span('disabled', txt);        
      return this._a(cls, txt);
    },
    _span: function(cls, txt){
      return ['<span class="', cls ,'">', txt ,'</span>'].to_str();
    },
    _a: function(cls, txt){
      return ['<a class="', cls ,'" href="javascript:void(0);">', txt, '</a>'].to_str();    
    }
  }

  $.fn.page = function(opts){
    var ret = null;
    this.each(function(){ ret = new pagination(this, opts);  });
    return ret;
  }

})(jQuery);

/***
 * ajax form
 */
(function(){
  function form(el, opts){

    this.fm = $(el);
    $.extend(true, this, form.settings, opts || {});
    // $.param(obj); {a:11,b:22} => a=11&b=222
    this.init();

  };

  form.settings = {
    params: {},
    offset: null, //tip message offset
    before: function(){ return true; },
    after: function(msg){}
  };

  form.prototype = {
    init: function(){
      var self = this;
      //this.fm.submit(function(){
        //return false;
        //return self.submit();
      //});
      this.submit();
    },
    submit: function(){
      var self = this;

      if(this.before()){
        //var loading = this.loading();
        var url = this.fm.attr('action');
        var method = this.fm.attr('method');
        var params = this.wrap();
        //alert(url + '::' + method + '::' + $.param(params));
        $m.post(url, params, function(json){
          self.success(json);
        })
        /**$.ajax({
          type: method,
          url: url+".json",
          data: params,
          cache: false,
          success: function(json){
            //loading.remove();
            //alert(msg);
            //self.tip(json);
            //setTimeout(function(){ tip.remove(); }, 5000);
            //self.after(json);
            self.success(json);
          }
        });**/
      }
      //stop default submit event
      return false;
    },
    wrap: function(){
      //alert(this.params['menu[parent_id]'])
      var params = this.params;
      //first search input(type = (hidden || text || password...))
      this.fm.find('input').each(function(){
        if(is_name(this.name)){
          params[this.name] = this.value;
        }
      });
      //second search textarea
      this.fm.find('textarea').each(function(){
        if(is_name(this.name)){
          params[this.name] = $(this).val();
        }
      });

      function is_name(name){
        if(typeof this.name == 'undefined'){
          console.log('attribute name is undefined');
          return false;
        }else if(this.name == null){
          console.log('attribute name is null');
          return false;
        }else if(/^\s.$/g.test(this.name)){
          console.log('attribute name is empty');
          return false;
        }else
          return true;
      };

      return params;
    },
    body_offset: function(){
      var body = $(document.body);
      var left = body.width()/3;
      var top = 40; //body.height()/4;
      return {left: left, top: top};
    },
    form_offset: function(){
      var off = this.fm.offset();
      off.left += this.fm.width()/6;
      return off;
    },
    flow_div: function(color, content){
      $('#flow_div', this.fm).remove();
      var offset = this.offset || this.body_offset();
      var loading = $(['<div id="flow_div" style="border-radius: 3px; -webkit-border-radius: 3px; -moz-border-radius: 3px; background: ',color, 
          ';padding: 10px; position: absolute; z-index: 100; left: ',offset.left,'px; top: ',offset.top,'px;">', content,'</div>'].join(''));
      this.fm.append(loading);
      return loading;
    },
    loading: function(){
      return this.flow_div('#fff','<div class="loading"></div>')
    },
    success: function(json){
      this.after(json);
      //var $_tip = null;
      /**if(typeof json.error != 'undefined'){
        var error = [];
        if(json.error instanceof Array){
          error = json.error
        }else if(typeof json.error == 'string'){
          error.push(json.error)
        }else{
          alert('error type not defined')
          return
        }
        //$_tip = this.tip(error.join("<br/>"))
        $m.tip(error.join('<br/>'))
        //setTimeout(function(){ $_tip.remove() }, 10000)
        return; 
      }**/
      //if(json.k == '1'){
        //$_tip = this.tip("操作执行成功");
        //setTimeout(function(){ $_tip.remove() }, 2000)
      /**}else if(json.k == '0'){
        var body = $(document.body);
        var left = body.width() - 200;

        var error = ['<ul>'];
        var i = 1;
        for(var p in json.v){
          error.push(['<li style="height:20px;">', i++, ', ', p, ': ', json.v[p].join("; "), '</li>'].to_str());
        }
        error.push('</ul>');
        //alert(error.to_str());

        this.tip(error.to_str()).offset({left: left});
      }else
        alert('ajax form result error !');
      **/

    },
    tip: function(message){
      return this.flow_div('#FFFFCA', message);
    }

  };

  $.fn.ajax_form = function(opts){
    var fms = [];
    this.each(function(){ fms.push(new form(this, opts)); });
    return fms;
  };
})(jQuery);

//body load
$(function(){
  $('a.btn-submit').click(function(){
    p = $(this).parent();
    while(p.attr('tagName').toLowerCase() != 'form')
      p = p.parent();
    p.ajax_form({offset: {left: 0, right: 0}, after: function(json){
      if(json == '1'){
      }else{
        alert(json.join(' '))
      }
    }})
    return false;
  })
})
