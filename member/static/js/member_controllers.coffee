angular.module('member.controllers', ['member.services'])
.controller("MembersControl", [
    '$scope', 'Members', "$cookieStore"

    ($scope, Members, $cookieStore) ->
        $scope.members = Members.query(
            username: $cookieStore.get('username')
            api_key: $cookieStore.get('apikey')
        )
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
