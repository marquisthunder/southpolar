angular.module('solarcell.controllers', ['solarcell.services'])
  .controller("SolarcellsControl", [
    '$scope', 'Solarcell', '$cookieStore', '$timeout'

    ($scope, Solarcell, $cookieStore, $timeout) ->
      $timeout ->
        Solarcell.query (
          username: $cookieStore.get('username')
          api_key:  $cookieStore.get('apikey')
        ), (solarcells) ->
          $scope.solarcells = solarcells.objects
          console.warn $scope

        $timeout arguments.callee, 2000
      , 2000
  ])


