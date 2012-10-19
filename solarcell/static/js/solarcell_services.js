(function() {

    angular.module('solarcell.services', []).factory("Solarcell", function($resource) {
        return $resource("/api/solarcells/solarcell/:solarcellid", {
            format: "json"
        }, {
            query: {
                method: "GET",
                params: {},
                isArray: false
            }
        });
    });

}).call(this);

