//= require jquery
//= require jquery_ujs
//= require utilities

(function(u) {
  this.WebFontConfig = {
    google: { families: ['Lato:400,900:latin,latin-ext'] }
  };
  u.ready(function () {
    var wf = document.createElement('script');
    wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
      '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
    wf.type = 'text/javascript';
    wf.async = 'true';
    var s = u.find('script');
    s.parentNode.insertBefore(wf, s);
  });
}).call(this, Util);
