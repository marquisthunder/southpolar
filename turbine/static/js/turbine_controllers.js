(function() {

    angular.module('turbine.controllers', ['turbine.services']).controller("TurbinesControl", [
        '$scope', 'Turbine', '$cookieStore', '$timeout', function($scope, Turbine, $cookieStore, $timeout) {
            return $timeout(function() {
                Turbine.query({
                    username: $cookieStore.get('username'),
                    api_key: $cookieStore.get('apikey')
                }, function(turbines) {
                    $scope.turbines = turbines.objects;
                    return console.warn($scope);
                });
                return $timeout(arguments.callee, 2000);
            }, 2000);
        }
    ]).controller("TurbineDetailControl", [
        '$scope', 'Turbine', '$routeParams', '$cookieStore', '$timeout', function($scope, Turbine, $routeParams, $cookieStore, $timeout) {
            return $timeout(function() {
                $scope.turbine = Turbine.get({
                    turbineid: $routeParams.turbineid,
                    username: $cookieStore.get('username'),
                    api_key: $cookieStore.get('apikey')
                });
                return $timeout(arguments.callee, 2000);
            }, 2000);
        }
    ]).controller("TurbineHourHistoryControl", [
        "$scope", "$routeParams", "TurbineHourHistory", "$cookieStore", "$timeout", "$log", function($scope, $routeParams, TurbineHourHistory, $cookieStore, $timeout, $log) {
            return $scope.turbinedata = TurbineHourHistory.query({
                turbineid: $routeParams.turbineid,
                username: $cookieStore.get('username'),
                api_key: $cookieStore.get('apikey')
            }, function(turbinedata) {
                var data, timestamp;
                timestamp = (function() {
                    var _i, _len, _results;
                    _results = [];
                    for (_i = 0, _len = turbinedata.length; _i < _len; _i++) {
                        data = turbinedata[_i];
                        _results.push(new Date(data['timestamp']));
                    }
                    return _results;
                })();
                return $log.warn(timestamp);
            });
        }
    ]);

}).call(this);
