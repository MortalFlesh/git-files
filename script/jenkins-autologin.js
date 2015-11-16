console.log('jenkins-autologin');
(function ($) {
    $(document).ready(function () {
        
        var location = window.location.href;
        
        if (location.indexOf('/login')) {
            // login
            jQuery('form[name="login"]').submit();
        } else if (jQuery('.login').length) {
            // to login page
            jQuery('.login a b').click();
        }
    });
})(jQuery);
