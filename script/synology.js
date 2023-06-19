console.log('Synology NAS scripts');

(function () {
    'use strict';

    const waitFor = 500
    const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms))

    async function download($showDownloadDialog, url) {
        console.log(`Download ${url}`)
        console.log(`Opening download dialog`)
        $showDownloadDialog.click()

        await sleep(waitFor)
        console.log(`Filling download dialog`)
        document.querySelector('.active-win textarea').value = url

        await sleep(waitFor)
        console.log(`Downloading ...`)
        document.querySelector('.active-win .x-toolbar-right-row .x-btn-text[aria-label=OK]').click()
        console.log(`Done.`)
    }

    window.downloadMultiple = (source) => {
        const $showDownloadDialogs = document.getElementsByClassName('syno-dl-a_bt_add')
        if ($showDownloadDialogs.length == 0) {
            console.log('Download Station is not opened.')
            return
        }
        const $showDownloadDialog = $showDownloadDialogs[0]

        const urls = Array.isArray(source)
            ? source
            : source.split('\n').filter((line) => line.trim().length > 0)

        urls.reduce(
            (p, url) => p.then(() => download($showDownloadDialog, url)),
            Promise.resolve()
        );
    }

    console.log('window.downloadMultiple() is ready.')
})();
