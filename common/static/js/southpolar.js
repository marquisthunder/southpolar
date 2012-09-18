// Generated by CoffeeScript 1.3.1
(function() {
  var southpolar;

  southpolar = angular.module("southpolar", ["ngResource", "ngCookies", "ui", "portal.services", "portal.controllers", "turbine.services", "turbine.controllers"]);

  southpolar.config([
    "$interpolateProvider", "$routeProvider", function($interpolateProvider, $routeProvider) {
      $interpolateProvider.startSymbol("((");
      $interpolateProvider.endSymbol("))");
      return $routeProvider.when("/", {
        templateUrl: "/members/",
        controller: "MembersControl"
      }).when("/member/:memberId", {
        templateUrl: "/members/get/",
        controller: "MemberDetailControl"
      }).when("/login", {
        templateUrl: "/portal/login/",
        controller: "LoginControl"
      }).when("/logout", {
        templateUrl: "/portal/logout/",
        controller: "LogoutControl"
      }).when("/register", {
        templateUrl: "/portal/register/",
        controller: "RegisterControl"
      }).when("/turbines", {
        templateUrl: "/turbine/"
      }).when("/turbine/:turbineid", {
        templateUrl: "/turbine/get/"
      }).when("/solarcells", {
        templateUrl: "/solarcell/"
      }).when("/solarcell/:solarcellid", {
        templateUrl: "/solarcell/get/"
      }).when("/surveillance", {
        templateUrl: "/surveillance/"
      }).when("/surveillance/:surveillanceid", {
        templateUrl: "/surveillance/get/"
      }).when("/meteors", {
        templateUrl: "/meteor/"
      }).when("/meteor/:meteorid", {
        templateUrl: "/meteor/get/"
      }).when("/power", {
        templateUrl: "/power/"
      }).when("/power/:powerid", {
        templateUrl: "/power/get/"
      }).when("/batteries", {
        templateUrl: "/battery/"
      }).when("/battery/:batteryid", {
        templateUrl: "/battery/get/"
      }).when("/serviceconf", {
        templateUrl: "/service/serviceconf/",
        controller: "LoginControl"
      }).otherwise({
        redirectTo: "/"
      });
    }
  ]);

  southpolar.value("ui.config", {
    select2: {
      placeholder: "Select a member type",
      allowClear: true
    },
    jq: {
      accordion: {
        header: "h3"
      }
    }
  });

}).call(this);
