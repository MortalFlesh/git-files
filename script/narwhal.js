console.log('Narwhal scripts');

(function ($) {
    'use strict';

    $(document).ready(() => {

        //
        // Configurations, selectors, ...
        //

        const selector = {
            editButton: { id: 'n-edit-button', selector: '#n-edit-button' },
            clickable: { class: 'n-clickable', selector: '.n-clickable' },
        }

        const selectors = [
            { title: 'edit button', selector: 'a[href^="/edit"]:first', attr: ['id', selector.editButton.id] },
            { title: 'description row', selector: 'tr:contains("description"):first > td:first', attr: ['class', selector.clickable.class] },
            { title: 'template row', selector: 'tr:contains("url template"):first > td:first', attr: ['class', selector.clickable.class] },
        ]

        // distribute attributes to elements by selectors above
        selectors.forEach(({ selector, attr }) => {
            const $item = $(selector)
            if ($item.length) {
                $item.attr(...attr)
            }
        })

        //
        // Helpers
        //

        const ifExistsDo = ($item, action) => { if ($item.length) action($item) }

        //
        // Events, handlers, helpers ...
        //

        // edit on `E` keyup
        $('body').on('keyup', ({ key }) => {
            if (key === 'e') {
                ifExistsDo($(selector.editButton.selector), ($edit) => {
                    window.location.href = $edit.first().attr('href')
                })
            }
        })

        // make links in description clickable
        ifExistsDo($(selector.clickable.selector), ($clickable) => {
            $clickable.each((_, item) => {
                const $item = $(item)
                const content =
                    $item
                        .html()
                        .split(' ')
                        .map((word) => word.startsWith('http') ? `<a href="${word}" target="_blank">${word}</a>` : word)
                        .join(' ')
                $item.html(content)
            })
        })

    });
})(window.jQuery);
