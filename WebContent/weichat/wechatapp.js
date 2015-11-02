/**
 * 
 */
angular.module('wechat', ['ui.bootstrap','ui.router'])  
    .run()
    .config(function($stateProvider, $urlRouterProvider){
    
    	 $stateProvider
         .state('login', {
             url: '/login',
             //abstract: true,
             templateUrl: 'weichat/templates/login.html',
             controller: 'loginCtrl'
         });
    	 $urlRouterProvider.otherwise('/login');
    });
angular.module('wechat.controller', []);
angular.module('wechat.service', []);