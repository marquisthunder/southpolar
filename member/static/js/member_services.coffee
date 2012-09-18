angular.module('member.services', [])
#register RESTful services
.factory "Members", ($resource) ->
    $resource "/api/members/member/:memberId",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false
