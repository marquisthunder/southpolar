// Generated by CoffeeScript 1.3.3
(function() {

  angular.module('member.controllers', ['member.services']).controller("MembersControl", [
    '$scope', 'Members', "$cookieStore", function($scope, Members, $cookieStore) {
      return $scope.members = Members.query({
        username: $cookieStore.get('username'),
        api_key: $cookieStore.get('apikey')
      });
    }
  ]).controller("MemberDetailControl", [
    "$scope", "$routeParams", "Members", "$cookieStore", function($scope, $routeParams, Members, $cookieStore) {
      $scope.member = Members.get({
        memberId: $routeParams.memberId,
        username: $cookieStore.get('username'),
        api_key: $cookieStore.get('apikey')
      }, function(member) {});
    }
  ]).controller("ProfileControl", [
    "$scope", "$location", "$routeParams", "Members", function($scope, $location, $routeParams, Members) {
      var _this = this;
      $scope.save = function() {
        return Members.get({
          member: $scope.member
        }, function(member) {
          _this.original = member;
          return $scope.member = new Members(self.original);
        });
      };
      $scope.isClean = function() {
        return angular.equals(_this.original, $scope.member);
      };
      $scope.destroy = function() {
        return _this.original.destroy(function() {
          return $location.path('/list');
        });
      };
      return $scope.save = function() {
        return $scope.Members.update(function() {
          return $location.path('/');
        });
      };
    }
  ]);

}).call(this);
