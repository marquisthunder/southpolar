// Generated by CoffeeScript 1.3.1
(function() {

  angular.module('member.services', []).factory("Members", function($resource) {
    return $resource("/api/members/member/:memberId", {
      format: "json"
    }, {
      query: {
        method: "GET",
        params: {},
        isArray: false
      }
    });
  });

}).call(this);