angular.module('portal.services', [])
#register RESTful services
.factory "Login", ($resource) ->
    $resource "/api/members/portal/login",
        save:
            method: "POST"
            params: {}
            isArray: false

.factory "Logout", ($resource) ->
    $resource "/api/members/portal/logout",
        get:
            method: "GET"
            params: {}
            isArray: false

.factory "Register", ($resource) ->
    $resource "/api/members/portal/register",
        save:
            method: "POST"
            params: {}
            isArray: false

.factory "Checkusername", ($resource) ->
    $resource "/api/members/portal/checkusername",
        get:
            method: "GET"
            params: {}
            isArray: false
