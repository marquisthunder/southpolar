angular.module('turbine.services', [])
#register RESTful services
.factory "TurbineData", ($resource) ->
    $resource "/api/turbines/turbine/:turbineid",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false

.factory "TurbineHistory", ($resource) ->
    $resource "/api/turbines/turbinedata/:turbineid/hour",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false

.factory "TurbinesHistory", ($resource) ->
    $resource "/api/turbines/turbinedata",
        format: "json"
    ,
        query:
            method: "GET"
            params: {}
            isArray: false
