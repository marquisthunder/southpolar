// Generated by CoffeeScript 1.3.1
(function() {

  angular.module('portal.services', []).factory("Members", function($resource) {
    return $resource("/api/members/member/:memberId", {
      format: "json"
    }, {
      query: {
        method: "GET",
        params: {},
        isArray: false
      }
    });
  }).factory("Login", function($resource) {
    return $resource("/api/members/portal/login", {
      save: {
        method: "POST",
        params: {},
        isArray: false
      }
    });
  }).factory("Logout", function($resource) {
    return $resource("/api/members/portal/logout", {
      get: {
        method: "GET",
        params: {},
        isArray: false
      }
    });
  }).factory("Register", function($resource) {
    return $resource("/api/members/portal/register", {
      save: {
        method: "POST",
        params: {},
        isArray: false
      }
    });
  }).factory("Checkusername", function($resource) {
    return $resource("/api/members/portal/checkusername", {
      get: {
        method: "GET",
        params: {},
        isArray: false
      }
    });
  });

}).call(this);