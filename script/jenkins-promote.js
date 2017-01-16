console.log('jenkins-promote');

(function (w) {
    function initJenkinsPromote($) {
        $(document).ready(function () {

            if ($('#buildHistory').length > 0) {
                console.log('jenkins-promote-ready');

                window.custom_jqUiLoaded = false;

                function promotionDialog(baseUrl, response) {
                    var $promotion = $('<iframe id="custom-promotion-id" height="400" width="280"></iframe>')
                        .attr('src', baseUrl + 'promotion/');

                    var $promotionContainer = $('#custom-promotion-container');
                    $promotionContainer
                        .empty()
                        .append($promotion)
                        .dialog();

                    setTimeout(function () {
                        scrollToEndOfIframe('#custom-promotion-id');
                    }, 1000);
                }

                function scrollToEndOfIframe(iframeSelector) {
                    var $contents = $(iframeSelector).contents();

                    $contents.scrollTop($contents.height());
                }

                function showPromotion() {
                    if (window.custom_jqUiLoaded) {
                        promotionDialog(baseUrl);
                    } else {
                        $.getScript('//code.jquery.com/ui/1.11.4/jquery-ui.js', function () {
                            console.log('jQuery-UI loaded');
                            window.custom_jqUiLoaded = true;

                            promotionDialog(baseUrl);
                        });
                    }
                }

                window.showPromotion = showPromotion;

                var $build = $('.pane.build-name:first', '#buildHistory');
                var $buildLinks = $build.find('a');
                var $buildConsoleLink = $buildLinks.length > 1 ? $buildLinks.first() : $buildLinks;

                var consoleUrl = $buildConsoleLink.attr('href');
                var baseUrl = consoleUrl.substr(0, consoleUrl.length - 'console'.length);   // fe: /view/EDU/job/vysokeskoly.cz/36/
                var buildNumber = $build.text().replace(/[^\d]*/g, '');

                var $button = $('<button type="button" onclick="showPromotion()"></button>')
                    .text('#' + buildNumber)
                    .attr('title', 'Promotion')
                    .css({cursor: 'pointer'});
                var $spanWithButton = $('<span></span>').append($button);

                var $container = $('<div id="custom-promotion-container"></div>')
                    .hide()
                    .css({border: '3px solid red', borderRadius: '10px', padding: '10px', background: '#fff'});

                $build
                    .empty()
                    .append($buildConsoleLink)
                    .append($spanWithButton)
                    .append($container);
            }
        });
    }

    function loadScript(url, callback) {
        // Adding the script tag to the head as suggested before
        var head = document.getElementsByTagName('head')[0];
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = url;

        // Then bind the event to the callback function.
        // There are several events for cross browser compatibility.
        script.onreadystatechange = callback;
        script.onload = callback;

        // Fire the loading
        head.appendChild(script);
    }

    if (w.jQuery === undefined) {
        loadScript('//code.jquery.com/jquery-1.12.4.min.js', function () {
            w.jQuery.noConflict();
            console.log('jenkins-promote: jQuery loaded');
            initJenkinsPromote(w.jQuery);
        });
    } else {
        initJenkinsPromote(w.jQuery);
    }
})(window);
