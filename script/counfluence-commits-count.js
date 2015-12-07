console.log('Confluence - commits count');

(function($){
    $(document).ready(function(){
        var count = $('.commit-row').length;
        $('.menu-item.active-tab a').append(' (' + count + ')');
    });
})(jQuery);
