"use strict"
angular.module('portal.controllers', ['portal.services'])
.controller("LoginControl", [
    "$scope", "$location", "Login", "$cookieStore", "$log"

    ($scope, $location, Login, $cookieStore, $log) ->
        $scope.$log = $log
        $scope.master = {}

        $scope.isClean = ->
            angular.equals $scope.master, $scope.member

        $scope.reset = ->
            $scope.member = angular.copy $scope.master

        $scope.login = ->
            $log.warn $scope.member
            Login.save(
                username: $scope.member.username
                password: $scope.member.password
            , (apitoken) ->
                $log.warn apitoken['apikey']
                $cookieStore.put('username', apitoken['username'])
                $cookieStore.put('apikey', apitoken['apikey'])
                $location.path '/'
            )

        $scope.select2 = ""
])


.controller("LogoutControl", [
    "$scope", "$location", "Logout", "$cookieStore", "$log"

    ($scope, $location, Logout, $cookieStore, $log) ->
        Logout.get(
            {}
        , ->
            $cookieStore.remove('username')
            $cookieStore.remove('apikey')
        )
])
 

.controller("RegisterControl", [
    "$scope", "$location", "Register", "Checkusername", "$log"

    ($scope, $location, Register, Checkusername, $log) ->
        $scope.$log = $log
        $scope.master = {}

        $scope.validusername = ->
            Checkusername.get(
                username: $scope.member.username
            , (payload) ->
                return payload['success']
            )

        $scope.isClean = ->
            angular.equals master, $scope.member

        $scope.reset = ->
            $scope.member = angular.copy $scope.master

        $scope.register = ->
            $log.warn $scope.member
            Register.save(
                username: $scope.member.username
                password: $scope.member.password
            , (apitoken) ->
                $log.warn apitoken['apikey']
                $location.path '/'
            )

        return
])
