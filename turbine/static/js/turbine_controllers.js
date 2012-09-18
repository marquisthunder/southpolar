// Generated by CoffeeScript 1.3.1
(function() {
  "use strict";

  angular.module('turbine.controllers', ['turbine.services']).controller("TurbinesControl", [
    '$scope', 'Turbines', "$cookieStore", function($scope, Turbines, $cookieStore) {
      return $scope.turbines = Members.query({
        username: $cookieStore.get('username'),
        api_key: $cookieStore.get('apikey')
      });
    }
  ]).controller("TurbineDetailControl", [
    "$scope", "$routeParams", "Turbines", "$cookieStore", function($scope, $routeParams, Turbines, $cookieStore) {
      $scope.turbine = Turbines.get({
        memberId: $routeParams.memberId,
        username: $cookieStore.get('username'),
        api_key: $cookieStore.get('apikey')
      }, function(turbine) {});
      return $scope.turbine;
    }
  ]);

}).call(this);