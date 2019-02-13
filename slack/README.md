Slack changes
=============

## Dark theme
- github: https://github.com/widget-/slack-black-theme
- file to append: `ssb-interop.js` (current version: `3.1.0`)
	- location `findFile /Applications/Slack.app/Contents/ ssb-interop.js`
- append file with following code (currently from [issue](https://github.com/widget-/slack-black-theme/issues/39#issuecomment-356698404))

```javascript
// First make sure the wrapper app is loaded
document.addEventListener("DOMContentLoaded", function() {

   // Then get its webviews
   let webviews = document.querySelectorAll(".TeamView webview");

   // Fetch our CSS in parallel ahead of time
   const cssPath = 'https://cdn.rawgit.com/widget-/slack-black-theme/master/custom.css';
   let cssPromise = fetch(cssPath).then(response => response.text());

   let customCustomCSS = `
   :root {
      /* Modify these to change your theme colors: */
      --primary: #09F;
      --text: #CCC;
      --background: #080808;
      --background-elevated: #222;
   }
   div.c-message.c-message--light.c-message--hover
   {
   color: #fff !important;
   background-color: #222 !important;
   }

   div.c-virtual_list__scroll_container {
    background-color: #282C34 !important;
   }
   .p-message_pane .c-message_list:not(.c-virtual_list--scrollbar), .p-message_pane .c-message_list.c-virtual_list--scrollbar > .c-scrollbar__hider {
    z-index: 0;
   }

   div.comment.special_formatting_quote.content,.comment_body{
    color: #ABB2BF !important;
   }

   div.c-message:hover {
    background-color: #3B4048 !important;
   }

   div.c-message_attachment.c-message_attachment{
    color: #7c7b7b !important;
   }

   span.c-message_attachment__pretext{
    color: #7c7b7b !important;
   }

   hr.c-message_list__day_divider__line{
    background: #abb2bf !important;
   }

   div.c-message_list__day_divider__label__pill{
    background: #abb2bf !important;
   }   

   span.c-message__body,
   a.c-message__sender_link,
   span.c-message_attachment__media_trigger.c-message_attachment__media_trigger--caption,
   div.p-message_pane__foreword__description span,
   span.c-message_kit__text
   {
       color: #afafaf !important;
   }

   pre.special_formatting{
     background-color: #222 !important;
     color: #8f8f8f !important;
     border: solid;
     border-width: 1 px !important;
    
   }

   // NOT WORKING
   // div.ql-editor.c-message__editor__input {
   //  background: #2c2d30 !important;
   // }
   //
   // div.c-message--light .c-message--highlight .c-message--editing .c-message--highlight_yellow_bg{
   //  background: #3B4048 !important;
   //  border: none !important;
   // }

    `

   // Insert a style tag into the wrapper view
   cssPromise.then(css => {
      let s = document.createElement('style');
      s.type = 'text/css';
      s.innerHTML = css + customCustomCSS;
      document.head.appendChild(s);
   });

   // Wait for each webview to load
   webviews.forEach(webview => {
      webview.addEventListener('ipc-message', message => {
         if (message.channel == 'didFinishLoading')
            // Finally add the CSS into the webview
            cssPromise.then(css => {
               let script = `
                     let s = document.createElement('style');
                     s.type = 'text/css';
                     s.id = 'slack-custom-css';
                     s.innerHTML = \`${css + customCustomCSS}\`;
                     document.head.appendChild(s);
                     `
               webview.executeJavaScript(script);
            })
      });
   });
});

```
