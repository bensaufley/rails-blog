//= require codemirror
//= require_tree ../../../../vendor/assets/javascripts/codemirror-modes/.
//= require_self

(function($, cm) {
  'use strict';

  cm.keyMap.default["Shift-Tab"] = "indentLess";
  cm.keyMap.default["Tab"] = "indentMore";

  $(function() {
    $('[data-codemirror]').each(function() {
      cm.fromTextArea(this, {
        mode: 'gfm',
        value: this.value,
        lineNumbers: true,
        theme: 'solarized'
      });
    });
  });
}).call(this, jQuery, CodeMirror);
