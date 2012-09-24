southpolar = angular.module("turbine.directives", ["turbine.controllers"])

.directive("powerChart", [

() ->

    restrict: 'A',
    (scope, elm, attrs) ->
        console.warn 'e'
        elm.text('hello')
])
