//= require codemirror
//= require_self

(function(cm, u) {
  'use strict';

  cm.keyMap.default['Shift-Tab'] = 'indentLess';
  cm.keyMap.default['Tab'] = 'indentMore';

  u.ready(function() {
    u.all('[data-codemirror]').forEach(function(el) {
      cm.fromTextArea(el, {
        lineNumbers: true,
        lineWrapping: true,
        mode: 'gfm',
        theme: 'solarized dark',
        value: el.value
      });
    });
  });
}).call(this, CodeMirror, Util);
