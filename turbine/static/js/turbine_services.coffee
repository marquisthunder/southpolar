angular.module('turbine.services', [])
#register RESTful services
.factory "Turbines", ($resource) ->
    $resource "/api/turbines/turbine/:turbineid",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false
