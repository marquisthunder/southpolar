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
            $scope.turbine = Turbine.query(
                turbineid: $routeParams.turbineid
                username: $cookieStore.get('username')
                api_key:  $cookieStore.get('apikey')
            )
            $timeout arguments.callee, 500
        , 500
])

.controller("TurbineHourHistoryControl", [
    "$scope", "$routeParams", "TurbineHourHistory", "$cookieStore", "$timeout"

    ($scope, $routeParams, TurbineHourHistory, $cookieStore, $timeout) ->
        $timeout ->
            $scope.turbine = TurbineHourHistory.get(
                #datatype: $routeParams.datatype
                turbineid: $routeParams.turbineid
                username: $cookieStore.get('username')
                api_key:  $cookieStore.get('apikey')
            , (turbine) ->
            )
            $timeout arguments.callee, 500
        , 500
])
