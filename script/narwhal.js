console.log('Narwhal scripts');

(function ($) {
    'use strict';

    //
    // Helpers
    //

    const ifExistsDo = ($item, action) => { if ($item.length) action($item) }

    const loadStyle = (url) =>
        (new Promise((resolve, reject) => {
            const $style = $('<link rel="stylesheet">')
                .attr('href', url)
                .ready(resolve)
            $('head').append($style);
        }))

    const loadScriptAndWait = (url, waitFor) =>
        (new Promise((resolve, reject) => {
            const $script = $('<script type="text/javascript">')
                .attr('src', url)
                .ready(resolve)
            $('head').append($script);
        })
            .then(() => (new Promise((resolve, reject) => {
                setTimeout(resolve, waitFor)
            })))
        )

    $(document).ready(() => {

        //
        // Configurations, selectors, ...
        //

        const selector = {
            editButton: { id: 'n-edit-button', selector: '#n-edit-button' },
            clickable: { class: 'n-clickable', selector: '.n-clickable' },
            jinja2UrlTemplate: { id: 'n-jinja2-urlTemplate', selector: '#n-jinja2-urlTemplate' },
            metaData: { id: 'n-meta', selector: '#n-meta' },
            metaDataType: { id: 'n-meta-type', selector: '#n-meta-type' },
            artifactItem: { class: 'n-artifact-item', selector: '.n-artifact-item' },
            artifactItemId: { id: 'n-artifact-id', selector: '#n-artifact-id-' },
        }

        const selectors = [
            { title: 'edit button', selector: 'a[href^="/edit"]:first', attr: { id: selector.editButton.id } },
            { title: 'artifact item', selector: '.tbl-artifact tr', attr: { class: selector.artifactItem.class } },
            { title: 'artifact item id', selector: '.tbl-artifact tr', attr: { id: selector.artifactItemId.id, data: 'id' } },

            // clickable content
            { title: 'description row', selector: 'tr:contains("description"):first > td:first', attr: { class: selector.clickable.class } },
            { title: 'template row', selector: 'tr:contains("url template"):first > td:first', attr: { class: selector.clickable.class } },

            // jinja
            { title: 'jinja2 urlTemplate', selector: 'input[name="url_template"]', attr: { id: selector.jinja2UrlTemplate.id } },

            // metadata
            { title: 'meta - type', selector: 'tr:contains("Meta") th small', attr: { id: selector.metaDataType.id } },
            { title: 'meta', selector: 'tr:contains("Meta") textarea[name="meta"]', attr: { id: selector.metaData.id } },
        ]

        // distribute attributes to elements by selectors above
        selectors.forEach(({ selector, attr }) => {
            ifExistsDo($(selector), ($item) => {
                if (attr.hasOwnProperty('class')) {
                    $item.addClass(attr.class)
                } else if (attr.hasOwnProperty('id') && attr.hasOwnProperty('data')) {
                    $item.each((_k, singleItem) => {
                        const $singleItem = $(singleItem)
                        const id = `${attr.id}-${$singleItem.data(attr.data)}`
                        $singleItem.attr('id', id)
                    })
                } else if (attr.hasOwnProperty('id')) {
                    $item.attr('id', attr.id)
                }
            })
        })

        //
        // Events, handlers, helpers ...
        //

        // edit on `E` keyup
        $(document).on('keyup', ({ target: { tagName }, key }) => {
            const tag = tagName.toLocaleLowerCase()

            if (tag !== 'input' && tag !== 'textarea' && key === 'e') {
                ifExistsDo($(selector.editButton.selector), ($edit) => {
                    window.location.href = $edit.first().attr('href')
                })
            }
        })

        // make links in clickable class clickable
        ifExistsDo($(selector.clickable.selector), ($clickable) => {
            $clickable.each((_, item) => {
                const $item = $(item)
                const content =
                    $item
                        .html()
                        .split(' ')
                        .map((word) => word.startsWith('http') ? `<a href='${word}' target="_blank">${word}</a>` : word)
                        .join(' ')
                $item.html(content)
            })
        })

        // show jinja2 syntax in textarea with jinja2
        const highlightJinjaSyntax = (type, id) => {
            // https://codemirror.net/doc/manual.html
            return window.CodeMirror.fromTextArea(document.getElementById(id), {
                mode: { name: type, htmlMode: true },
                lineNumbers: true,
                tabSize: 2,
                extraKeys: {
                    Tab: (cm) => cm.execCommand("indentMore"),
                    "Shift-Tab": (cm) => cm.execCommand("indentLess"),
                },
            });
        }

        // transform urlTemplate input to textArea
        if (window.location.href.indexOf('/artifacts/') > 0) {
            ifExistsDo($(selector.jinja2UrlTemplate.selector), ($urlTemplate) => {
                const $textArea = $('<textarea>')
                    .attr('name', $urlTemplate.attr('name'))
                    .attr('id', $urlTemplate.attr('id'))
                    .addClass($urlTemplate.attr('class'))
                    .val($urlTemplate.val())

                $urlTemplate.replaceWith($textArea)
            })
        }

        // load script and enable highlighting
        if ($(selector.jinja2UrlTemplate.selector).length > 0 || $(selector.metaData.selector).length > 0) {
            Promise
                .all([
                    loadStyle('https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.44.0/codemirror.min.css'),
                    loadScriptAndWait('https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.44.0/codemirror.min.js', 300),
                ])
                .then(() => {
                    if (!window.hasOwnProperty('CodeMirror')) {
                        throw Error('CodeMirror was not loaded correctly ...')
                    }
                })
                .then(() => loadScriptAndWait('https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.44.0/mode/jinja2/jinja2.min.js', 300))
                .then(() => loadScriptAndWait('https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.44.0/mode/yaml/yaml.min.js', 300))
                .then(() => {
                    ifExistsDo($(selector.jinja2UrlTemplate.selector), ($_) => {
                        highlightJinjaSyntax('jinja2', selector.jinja2UrlTemplate.id).setSize('', '60px')
                    })

                    ifExistsDo($(selector.metaData.selector), ($_) => {
                        const typeText = $(selector.metaDataType.id).text()
                        const type = typeText.indexOf('jinja2') > 0
                            ? 'jinja2'
                            : typeText.indexOf('yaml')
                                ? 'yaml'
                                : ''

                        highlightJinjaSyntax(type, selector.metaData.id)
                    })
                })
                .then(() => {
                    $('.CodeMirror').css({ border: '1px solid #ccc', borderRadius: '4px' })
                })
                .catch((e) => console.error(e))
        }


        // add dashboard overview
        if (window.location.href.indexOf('/artifacts') > 0 && $(selector.artifactItem).length > 0) {
            $('.n-overview').remove()

            const example = [
                { id: 923, configurationId: 953, alias: 'thor (router)' },
                { id: 962, configurationId: 963, alias: 'rogue (person-filter)' },
                { id: 924, configurationId: 952, alias: 'ant-man (aggregator)' },
                { id: 965, configurationId: 966, alias: 'quicksilver (deriver)' },
                { id: 958, configurationId: 959, alias: 'hulk (data_processing-filter)' },
                { id: 960, configurationId: 961, alias: 'she-hulk (all-intent-filter)' },
                { id: 904, configurationId: 968, alias: 'loki (stator)' },
            ]

            const dashboardArtifactsOverview = localStorage.hasOwnProperty('dashboardArtifactsOverview')
                ? JSON.parse(localStorage.getItem('dashboardArtifactsOverview'))
                : []

            const $getArtifact = (id) => {
                const $artifact = $(`${selector.artifactItemId.selector}${id}`)

                return $artifact.length
                    ? $artifact
                    : $('<tr><td>id</td></tr>') // not all artifacts are shown on the page, but we can create a link
                        .append($(`<td><a href="/artifacts/${id}">artefact id: ${id}</a></td>`))
            }

            const $createAlias = (alias) => alias.length > 0
                ? $('<h3></h3>')
                    .text(alias)
                    .css({ fontSize: 12, margin: 0, textAlign: 'right' })
                : ''

            const $createArtifact = ($artifact) =>
                $('<h4></h4>')
                    .append($artifact.clone().find('td:nth-child(2)'))
                    .css({ fontSize: 12 })

            const $createConfiguration = ($configuration) => $configuration
                ? $('<h5></h5>')
                    .append($configuration.clone().find('td:nth-child(2)'))
                    .css({ fontSize: 11 })
                : ''

            const $createOverviewItem = ($artifact, $configuration, alias) =>
                $('<div class="n-overview-item"></div>')
                    .append($createAlias(alias))
                    .append($createArtifact($artifact))
                    .append($createConfiguration($configuration))
                    .css({ margin: '0 10px 10px 0', padding: 5, border: '1px solid black', borderRadius: 5, height: 80, float: 'left' })

            const $overview = $('<div class="n-overview"></div>').css({ paddingTop: 10, paddingBottom: 10 })

            dashboardArtifactsOverview.forEach(({ id, configurationId = 0, alias = '' }) => {
                $overview.append(
                    $createOverviewItem(
                        $getArtifact(id),
                        $getArtifact(configurationId),
                        alias
                    )
                )
            })

            $('h3:first').append(
                $overview.append($('<br style="clear: both">'))
            )
        }
    });
})(window.jQuery);
