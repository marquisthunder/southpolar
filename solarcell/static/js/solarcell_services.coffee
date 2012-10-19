angular.module('solarcell.services', [])
#register RESTful services
  .factory "Solarcell", ($resource) ->
    $resource "/api/solarcells/solarcell/:solarcellid",
      format: "json"
    ,
      query:
        method: "GET"
        params: {}
        isArray: false

