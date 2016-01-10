var Util = (function() {

  var ready = function(fn) {
    if (document.readyState != 'loading'){
      fn();
    } else {
      document.addEventListener('DOMContentLoaded', fn);
    }
  };

  var addListener = function(event, handler) {
    this.addEventListener(event, handler);
    return this;
  };

  var removeListener = function(event, handler) {
    this.removeEventListener(event, handler);
    return this;
  };

  return {
    ready: ready,
    on: addListener,
    off: removeListener
  };
}).call(this);
