(function() {
    "use strict";

    angular.module('portal.controllers', ['portal.services']).controller("LoginControl", [
        "$scope", "$location", "Login", "$cookieStore", "$log", function($scope, $location, Login, $cookieStore, $log) {
            $scope.$log = $log;
            $scope.master = {};
            $scope.isClean = function() {
                return angular.equals($scope.master, $scope.member);
            };
            $scope.reset = function() {
                return $scope.member = angular.copy($scope.master);
            };
            $scope.login = function() {
                $log.warn($scope.member);
                return Login.save({
                    username: $scope.member.username,
                    password: $scope.member.password
                }, function(payload) {
                    console.warn(payload);
                    $cookieStore.put('username', payload['username']);
                    $cookieStore.put('apikey', ['apikey']);
                    return $location.path('/');
                }, function(response, responseheaders) {
                    console.warn(response);
                    if (response.status === 401) {
                        return alert('something wrong');
                    }
                });
            };
            return $scope.select2 = "";
        }
    ]).controller("LogoutControl", [
        "$scope", "$location", "Logout", "$cookieStore", "$log", function($scope, $location, Logout, $cookieStore, $log) {
            return Logout.get({}, function() {
                $cookieStore.remove('username');
                return $cookieStore.remove('apikey');
            });
        }
    ]).controller("RegisterControl", [
        "$scope", "$location", "Register", "Checkusername", "$log", function($scope, $location, Register, Checkusername, $log) {
            $scope.$log = $log;
            $scope.master = {};
            $scope.validusername = function() {
                return Checkusername.get({
                    username: $scope.member.username
                }, function(payload) {
                    return payload['success'];
                });
            };
            $scope.isClean = function() {
                return angular.equals(master, $scope.member);
            };
            $scope.reset = function() {
                return $scope.member = angular.copy($scope.master);
            };
            $scope.register = function() {
                $log.warn($scope.member);
                return Register.save({
                    username: $scope.member.username,
                    password: $scope.member.password
                }, function(apitoken) {
                    $log.warn(apitoken['apikey']);
                    return $location.path('/');
                });
            };
        }
    ]);

}).call(this);
