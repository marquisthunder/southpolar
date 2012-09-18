southpolar = angular.module("southpolar",
    ["ngResource", "ngCookies", "ui", "portal.services", "portal.controllers",
     "member.services", "member.controllers", "turbine.services", "turbine.controllers"])
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
        ).when("/member/:memberId",
            templateUrl: "/members/get/"
            controller: "MemberDetailControl"
        ).when("/login",
            templateUrl: "/portal/login/"
            controller: "LoginControl"
        ).when("/logout",
            templateUrl: "/portal/logout/"
            controller: "LogoutControl"
        ).when("/register",
            templateUrl: "/portal/register/"
            controller: "RegisterControl"
        ).when("/turbines",
            templateUrl: "/turbine/"
            controller: "TurbinesControl"
        ).when("/turbine/:turbineid",
            templateUrl: "/turbine/get/"
            controller: "TurbineDetailControl"
        ).when("/solarcells",
            templateUrl: "/solarcell/"
            #controller: "SolarcellDetailControl"
        ).when("/solarcell/:solarcellid",
            templateUrl: "/solarcell/get/"
            #controller: "SolarcellDetailControl"
        ).when("/surveillance",
            templateUrl: "/surveillance/"
            #controller: "SurveillanceDetailControl"
        ).when("/surveillance/:surveillanceid",
            templateUrl: "/surveillance/get/"
            #controller: "SurveillanceDetailControl"
        ).when("/meteors",
            templateUrl: "/meteor/"
            #controller: "MeteorDetailControl"
        ).when("/meteor/:meteorid",
            templateUrl: "/meteor/get/"
            #controller: "MeteorDetailControl"
        ).when("/power",
            templateUrl: "/power/"
            #controller: "PowerDetailControl"
        ).when("/power/:powerid",
            templateUrl: "/power/get/"
            #controller: "PowerDetailControl"
        ).when("/batteries",
            templateUrl: "/battery/"
            #controller: "BatteryControl"
        ).when("/battery/:batteryid",
            templateUrl: "/battery/get/"
            #controller: "BatteryDetailControl"
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
