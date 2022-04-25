console.log('Cinemacity scripts');

(function ($) {
    'use strict';

    const ifExistsDo = ($item, action) => { if ($item.length) action($item) }
    $.fn.then = (f) => setTimeout(f, 500)

    $(document).ready(() => {
        //
        // Configurations, selectors, ...
        //

        // select "buy ticket" option and go to next screen
        ifExistsDo($('[name=rbType]'), ($type) => $type.click().then(() => $('.nextBtn').click()))

        // select 1 adult ticket and go to next screen
        // ifExistsDo($('#ddQunatity_0'), ($quantity) => $quantity.val(1).then(() => $('.actionBtn').click()))  // normally it would work like this
        ifExistsDo($('#ddQunatity_0'), ($quantity) => $quantity.val(1).then(() => eval($('#lbSelectSeats').attr('href'))))  // but they have "javascript:..." in href, so we need to eval this
    });
})(window.jQuery);
