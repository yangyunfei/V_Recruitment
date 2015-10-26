/**
 * 
 */

angular.module('wechatapp',['ui.bootstrap']).run();

//If you're a Browserify or Webpack user, you can do:
//var uibs = require('angular-ui-bootstrap')
//angular.module('wechatapp', [uibs]);



angular.module('wechatapp', ['ionic', 'agent.controllers', 'agent.services'])  //''
.run(function ($ionicPlatform,$ionicLoading,$timeout,$http) {
    $ionicPlatform.ready(function ($scope) {

        if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
            cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
            cordova.plugins.Keyboard.disableScroll(true);
        }

    });

})





.config(function ($stateProvider, $urlRouterProvider,$ionicConfigProvider) {

    // Ionic uses AngularUI Router which uses the concept of states
    // Learn more here: https://github.com/angular-ui/ui-router
    // Set up the various states which the app can be in.
    // Each state's controller can be found in controllers.js
    $ionicConfigProvider.backButton.icon('ion-ios7-arrow-back');
    $ionicConfigProvider.backButton.text('');
    $ionicConfigProvider.backButton.previousTitleText(false);
    $ionicConfigProvider.platform.ios.tabs.style('standard');
    $ionicConfigProvider.platform.ios.tabs.position('bottom');
    $ionicConfigProvider.platform.android.tabs.style('standard');
    $ionicConfigProvider.platform.android.tabs.position('standard');

    $ionicConfigProvider.platform.ios.navBar.alignTitle('center');
    $ionicConfigProvider.platform.android.navBar.alignTitle('left');

    $ionicConfigProvider.platform.ios.backButton.previousTitleText('').icon('ion-ios-arrow-thin-left');
    $ionicConfigProvider.platform.android.backButton.previousTitleText('').icon('ion-android-arrow-back');

    $ionicConfigProvider.platform.ios.views.transition('ios');
    $ionicConfigProvider.platform.android.views.transition('android');

    $stateProvider

        // setup an abstract state for the tabs directive
        .state('tab', {
            url: '/tab',
            abstract: true,
            templateUrl: 'templates/tabs.html',
            controller: 'AgentCtrl'
        })

        // Each tab has its own nav history stack:

        .state('tab.customer', {
            url: '/customer',
            views: {
                'customer': {
                    templateUrl: 'templates/customer.html',
                    //controller: 'DashCtrl'
                }
            }
        })

        .state('tab.store', {
            url: '/store',
            views: {
                'store': {
                    templateUrl: 'templates/store.html',
                }
            }
        })

        .state('tab.me', {
            url: '/me',
            views: {
                'me': {
                    templateUrl: 'templates/me.html',
                    controller: 'meCtrl'
                }
            }
        })

        .state('tab.wait', {
            url: '/wait',
            cache:false,
            views: {
                'wait': {
                    templateUrl: 'templates/wait.html',
                    controller: 'WaitCtrl'
                }
            }
        })
        .state('tab.solved', {
            url: '/solved',
            cache:false,
            views: {
                'solved': {
                    templateUrl: 'templates/solved.html',
                    controller: 'SolvedCtrl'
                }
            }
        })
        .state('nolook', {
            url: '/noLook/:id',
            templateUrl: 'templates/nolook.html',
            controller: 'NoLookCtrl'
        })
        .state('evaluate', {
            url: '/evaluate/:id',
            templateUrl: 'templates/evaluate.html',
            controller: 'EvaluateCtrl'
        })
        .state('tab.history', {
            url: '/history',
            cache:false,
            views: {
                'history': {
                    templateUrl: 'templates/history.html',
                    controller: 'HistoryCtrl'
                }
            }
        })
        //.state('tab.complete', {
        //    url: '/complete',
        //    cache:false,
        //    views: {
        //        'complete': {
        //            templateUrl: 'templates/complete.html',
        //            controller: 'CompleteCtrl'
        //        }
        //    }
        //})
        .state('tab.forward', {
            url: '/forward',
            cache:false,
            views: {
                'forward': {
                    templateUrl: 'templates/forward.html',
                    controller: 'ForwardCtrl'
                }
            }
        })
        .state('order', {
            url: '/order',
            templateUrl: 'templates/order.html',
            controller:'OrderCtrl'
        })
        .state('order.detail', {
            url: '/detail/:id',
            views: {
                'orderDetail':{
                templateUrl: 'templates/orderDetail.html',
                controller: 'OrderDetailCtrl'
                }
            }
        })
        .state('exchange', {
            url: '/exchange/:id',
            templateUrl: 'templates/exchange.html',
            controller: 'ExchangeCtrl'
        })
        .state('order.comments', {
            url: '/comments/:id',
            views: {
                'comments':{
                templateUrl: 'templates/comments.html',
                controller: 'CommentsCtrl'
                }
            }
        })
        .state('order.commentc', {
            url: '/commentc/:id',
            views: {
                'commentc':{
                templateUrl: 'templates/commentc.html',
                controller: 'CommentcCtrl'
                }
            }
        })

        .state('login', {
            url: '/login',
            templateUrl: 'templates/login.html',
            controller: 'LoginCtrl'
        }
    );

    // if none of the above states are matched, use this as the fallback
    $urlRouterProvider.otherwise('/login');

});
angular.module('agent.controllers', ['agent.services']);
angular.module('agent.services', ['ngResource']);