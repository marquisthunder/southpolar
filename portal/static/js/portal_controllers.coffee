"use strict"
angular.module('portal.controllers', ['portal.services'])
.controller("MembersControl", [
    '$scope', 'Members', "$cookieStore"

    ($scope, Members, $cookieStore) ->
        $scope.members = Members.query(
            username: $cookieStore.get('username')
            api_key: $cookieStore.get('apikey')
        )
        #console.log($scope.members);
])

.controller("MemberDetailControl", [
    "$scope", "$routeParams", "Members", "$cookieStore"

    ($scope, $routeParams, Members, $cookieStore) ->
        $scope.member = Members.get(
            memberId: $routeParams.memberId
            username: $cookieStore.get('username')
            api_key:  $cookieStore.get('apikey')
        , (member) ->
        )
        return
])

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


.controller("ProfileControl", [
    "$scope", "$location", "$routeParams", "Members"

    ($scope, $location, $routeParams, Members) ->
        $scope.save = =>
            Members.get(
                member: $scope.member
            , (member) =>
                @original = member
                $scope.member = new Members(self.original)
            )

        $scope.isClean = =>
            angular.equals @original, $scope.member
        
        $scope.destroy = =>
            @original.destroy(() ->
                $location.path '/list'
            )

        $scope.save = ->
            $scope.Members.update(() ->
                $location.path '/'
            )
])
