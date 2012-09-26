angular.module('turbine.controllers', ['turbine.services'])
.controller("TurbinesControl", [
    '$scope', 'Turbine', '$cookieStore', '$timeout'

    ($scope, Turbine, $cookieStore, $timeout) ->
        $timeout ->
            $scope.turbines = Turbine.query(
                username: $cookieStore.get('username')
                api_key:  $cookieStore.get('apikey')
            )
            $timeout arguments.callee, 2000
        , 2000
])

.controller("TurbineDetailControl", [
    '$scope', 'Turbine', '$routeParams', '$cookieStore', '$timeout'

    ($scope, Turbine, $routeParams, $cookieStore, $timeout) ->
        $timeout ->
            $scope.turbine = Turbine.get(
                turbineid: $routeParams.turbineid
                username: $cookieStore.get('username')
                api_key:  $cookieStore.get('apikey')
            )
            $timeout arguments.callee, 500
        , 500
])

.controller("TurbineHourHistoryControl", [
    "$scope", "$routeParams", "TurbineHourHistory", "$cookieStore", "$timeout", "$log"

    ($scope, $routeParams, TurbineHourHistory, $cookieStore, $timeout, $log) ->
        $scope.turbinedata = TurbineHourHistory.query(
            turbineid: $routeParams.turbineid
            username: $cookieStore.get('username')
            api_key:  $cookieStore.get('apikey')
        , (turbinedata) ->
            timestamp = (new Date(data['timestamp']) for data in turbinedata)
            $log.warn timestamp
        )
])
