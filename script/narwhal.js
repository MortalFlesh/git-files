console.log('Narwhal scripts');

(function ($) {
    'use strict';

    $(document).ready(() => {

        //
        // Configurations, selectors, ...
        //

        const id = {
            editButton: { id: 'n-edit-button', selector: '#n-edit-button' },
            description: { id: 'n-description-row', selector: '#n-description-row' },
        }

        const selectors = [
            { title: 'edit button', selector: 'a[href^="/edit"]:first', attr: [ 'id', id.editButton.id ]},
            { title: 'description row', selector: 'tr:contains(description):first > td:first', attr: [ 'id', id.description.id ]},
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
                ifExistsDo($(id.editButton.selector), ($edit) => {
                    window.location.href = $edit.first().attr('href')
                })
            }
        })

        // make links in description clickable
        ifExistsDo($(id.description.selector), ($description) => {
            const content =
                $description
                    .html()
                    .split(' ')
                    .map((word) => word.startsWith('http') ? `<a href="${word}" target="_blank">${word}</a>` : word)
                    .join(' ')
            $description.html(content)
        })

    });
})(window.jQuery);
