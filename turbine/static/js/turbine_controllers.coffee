"use strict"
angular.module('turbine.controllers', ['turbine.services'])
.controller("TurbinesControl", [
    '$scope', 'Turbines', "$cookieStore"

    ($scope, Turbines, $cookieStore) ->
        console.warn $cookieStore.get('username')
        $scope.turbines = Turbines.query(
            username: $cookieStore.get('username')
            api_key:  $cookieStore.get('apikey')
        )
])

.controller("TurbineDetailControl", [
    "$scope", "$routeParams", "Turbines", "$cookieStore"

    ($scope, $routeParams, Turbines, $cookieStore) ->
        $scope.turbine = Turbines.get(
            memberId: $routeParams.memberId
            username: $cookieStore.get('username')
            api_key:  $cookieStore.get('apikey')
        , (turbine) ->
        )
        $scope.turbine
])
