// Generated by CoffeeScript 1.3.3
(function() {

  angular.module('turbine.controllers', ['turbine.services']).controller("TurbinesControl", [
    '$scope', 'Turbine', '$cookieStore', '$timeout', function($scope, Turbine, $cookieStore, $timeout) {
      return $timeout(function() {
        $scope.turbines = Turbine.query({
          username: $cookieStore.get('username'),
          api_key: $cookieStore.get('apikey')
        });
        return $timeout(arguments.callee, 2000);
      }, 2000);
    }
  ]).controller("TurbineDetailControl", [
    '$scope', 'Turbine', '$routeParams', '$cookieStore', '$timeout', function($scope, Turbine, $routeParams, $cookieStore, $timeout) {
      return $timeout(function() {
        $scope.turbine = Turbine.query({
          turbineid: $routeParams.turbineid,
          username: $cookieStore.get('username'),
          api_key: $cookieStore.get('apikey')
        });
        return $timeout(arguments.callee, 500);
      }, 500);
    }
  ]).controller("TurbineHourHistoryControl", [
    "$scope", "$routeParams", "TurbineHourHistory", "$cookieStore", "$timeout", function($scope, $routeParams, TurbineHourHistory, $cookieStore, $timeout) {
      return $timeout(function() {
        $scope.turbine = TurbineHourHistory.get({
          turbineid: $routeParams.turbineid,
          username: $cookieStore.get('username'),
          api_key: $cookieStore.get('apikey')
        }, function(turbine) {});
        return $timeout(arguments.callee, 500);
      }, 500);
    }
  ]);

}).call(this);
