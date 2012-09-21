angular.module('bootstrap.directives', [])
.directive("dropdown", [

    (scope, element, attrs) ->
        jQuery('html').on 'click', -> 
            element.removeClass 'open'

        jQuery('.dropdown-toggle', element).on 'click', (e)-> 
            element.toggleClass 'open'
])

