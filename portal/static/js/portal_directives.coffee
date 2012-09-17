"use strict"
angular.module('southpolar.directives', [])
 
.directive 'validpasssword'
    require: 'ngModel',
    link: (scope, elm, attrs, ctrl) ->
        ctrl.$parsers.unshift (viewValue) ->
              angular.equals viewValue, scope.member.password
