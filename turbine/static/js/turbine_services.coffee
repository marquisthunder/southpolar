angular.module('turbine.services', [])
#register RESTful services
.factory "Turbines", ($resource) ->
    $resource "/api/turbines/turbinedata/:turbineid",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false
