southpolar = angular.module("southpolar", ["ngResource", "ngCookies", "ui", "southpolar.services", "southpolar.controllers"])
southpolar.config [
    "$interpolateProvider", "$routeProvider"

    ($interpolateProvider, $routeProvider) ->
        #change angular template tags
        $interpolateProvider.startSymbol "(("
        $interpolateProvider.endSymbol "))"
        
        #routes & multi-views
        $routeProvider.when("/",
            templateUrl: "/members/"
            controller: "MembersControl"
        ).when("/login",
            templateUrl: "/portal/login/"
            controller: "LoginControl"
        ).when("/logout",
            templateUrl: "/portal/logout/"
            controller: "LogoutControl"
        ).when("/register",
            templateUrl: "/portal/register/"
            controller: "RegisterControl"
        ).when("/:memberId",
            templateUrl: "/members/get/"
            controller: "MemberDetailControl"
        ).when("/serviceconf",
            templateUrl: "/service/serviceconf/"
            controller: "LoginControl"
        ).otherwise redirectTo: "/"
]

#angular-ui global config
southpolar.value "ui.config",
    select2:
        placeholder: "Select a member type",
        allowClear: true
    jq:
        accordion:
            header: "h3"

