console.log('jenkins-autologin');
(function ($) {
    $(document).ready(function () {
        
        var location = window.location.href;
        
        if (location.indexOf('/login') > 0) {
            // login - nejde protoze form nema bez kliku uzivatele udaje ulozene v browseru
                //jQuery('form[name="login"] input:first').click().focus().click();
                //jQuery(jQuery('form[name="login"] input')[1]).focus().click().focus().val();
        } else if (jQuery('.login').length) {
            // to login page
            // todo - osetrit odhlaseni (ma stejny selector...)
            jQuery('.login a b').click();
        }
    });
})(jQuery);
