(function() {

    angular.module('solarcell.controllers', ['solarcell.services']).controller("SolarcellsControl", [
        '$scope', 'Solarcell', '$cookieStore', '$timeout', function($scope, Solarcell, $cookieStore, $timeout) {
            return $timeout(function() {
                Solarcell.query({
                    username: $cookieStore.get('username'),
                    api_key: $cookieStore.get('apikey')
                }, function(solarcells) {
                    $scope.solarcells = solarcells.objects;
                    return console.warn($scope);
                });
                return $timeout(arguments.callee, 2000);
            }, 2000);
        }
    ]);

}).call(this);

