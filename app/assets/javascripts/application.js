//= require jquery
//= require jquery_ujs
//= require utilities

(function($) {
  this.WebFontConfig = {
    google: {families: ['Lato:400,900:latin,latin-ext']}
  };
  Util.ready(function () {
    var wf = document.createElement('script');
    wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
      '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
    wf.type = 'text/javascript';
    wf.async = 'true';
    var s = document.getElementsByTagName('script')[0];
    s.parentNode.insertBefore(wf, s);
  });
}).call(this, Util);
