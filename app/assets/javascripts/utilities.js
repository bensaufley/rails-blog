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

  var find = function(selector, scope) {
    if (scope == null) { scope = document; }
    return scope.querySelector(selector);
  };

  var all = function(selector, scope, native) {
    if (typeof scope == 'boolean') { native = scope; scope = document; }
    if (scope == null) { scope = document; }
    if (native == null) { native = false; }
    var results = scope.querySelectorAll(selector);
    if (native) { return results; }
    return [].map.call(results, function(obj) { return obj; });
  };

  var ajax = function(params) {
    var request = new XMLHttpRequest();
    request.open(params.type || 'GET', params.url, true);
    if (params.dataType) { request.responseType = params.dataType; }
    else if (/\.json(?:\?.*)?$/.test(params.url)) { request.responseType = 'json'; }
    request.onload = function() {
      if (this.status >= 200 && this.status <= 400) {
        if (typeof params.success == 'function') {
          var response = this.response;
          if (!request.responseType &&
              typeof response == 'string' &&
              /json/.test(this.getResponseHeader('content-type'))) {
            response = JSON.parse(response);
          }
          params.success(response, this.status, this);
        }
      } else {
        if (typeof params.error == 'function') { params.error(this, this.status, 'Server error'); }
      }
    };
    request.onerror = function(e) {
      if (typeof params.error == 'function') { params.error(this, this.status, e.error); }
    };
    request.send();
  };

  return {
    ready: ready,
    on: addListener,
    off: removeListener,
    all: all,
    find: find,
    ajax: ajax
  };
}).call(this);
