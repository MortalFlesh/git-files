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

	span.c-message__body,
	a.c-message__sender_link,
	span.c-message_attachment__media_trigger.c-message_attachment__media_trigger--caption,
	div.p-message_pane__foreword__description span
	{
			color: #afafaf !important;
	}

	pre.special_formatting{
		background-color: #222 !important;
		color: #8f8f8f !important;
		border: solid;
		border-width: 1 px !important;
		
	}
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
