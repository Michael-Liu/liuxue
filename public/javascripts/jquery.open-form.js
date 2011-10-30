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
