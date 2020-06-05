"use strict";
var KTSessionTimeoutDemo = function () {

    var initDemo = function () {
        $.sessionTimeout({
            title: 'Session Timeout Notification',
            message: 'Your session is about to expire.',
            keepAliveUrl: 'keepalive.jsp',
            redirUrl: 'UserController?pageName=logout',
            logoutUrl: 'UserController?pageName=logout',
            //warnAfter: 3000, //warn after 5 seconds
            warnAfter: 900000, //warn after 15 minutes	//Updated By Poovarasan 
            //redirAfter: 3500, //redirect after 16 seconds
            redirAfter: 960000, //redirect after 16 seconds		//Updated By Poovarasan 
            ignoreUserActivity: true,
            countdownMessage: 'Redirecting in {timer} seconds.',
            countdownBar: true
        });
    }

    return {
        //main function to initiate the module
        init: function () {
            initDemo();
        }
    };

}();

jQuery(document).ready(function() {    
    KTSessionTimeoutDemo.init();
});