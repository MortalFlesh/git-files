console.log('Narwhal scripts');

(function ($) {
    'use strict';

    $(document).ready(() => {

        // edit on `E` keyup
        $('body').on('keyup', ({ key }) => {
            if (key === 'e') {
                window.location.href = $('a[href^="/edit"]').first().attr('href')
            }
        })

    });
})(window.jQuery);
