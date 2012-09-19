angular.module('turbine.services', [])
#register RESTful services
.factory "TurbineData", ($resource) ->
    $resource "/api/turbines/turbinedata/:turbineid",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false

.factory "Turbines", ($resource) ->
    $resource "/api/turbines/turbine/:turbineid",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false
