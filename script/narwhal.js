console.log('Narwhal scripts');

(function ($) {
    'use strict';

    $(document).ready(() => {

        // edit on `E` keyup
        $('body').on('keyup', ({ key }) => {
            if (key === 'e') {
                const $edit = $('a[href^="/edit"]')
                if ($edit.length > 0) {
                    window.location.href = $edit.first().attr('href')
                }
            }
        })

    });
})(window.jQuery);
