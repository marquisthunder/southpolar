angular.module('turbine.services', [])
#register RESTful services
.factory "Turbine", ($resource) ->
    $resource "/api/turbines/turbine/:turbineid",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false

.factory "TurbineHourHistory", ($resource) ->
    $resource "/api/turbines/turbinedata/:turbineid/hour",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false

.factory "TurbineMinuteHistory", ($resource) ->
    $resource "/api/turbines/turbinedata/:turbineid/minute",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false
