let nativePort;

async function updateTabs () {
	const tabs = await browser.tabs.query({})
	nativePort.postMessage({
		event: 'updateTabs',
		payload: tabs.map(tab => { return {
				url: tab.url,
				title: tab.title,
				active: tab.active,
				id: tab.id,
				favIconUrl: tab.favIconUrl
			} })
	})
}

(async () => {
	nativePort = browser.runtime.connectNative("dbus_tabs")
	if (nativePort.error) { console.error(nativePort) }
	nativePort.onMessage.addListener(async msg => {
		console.log(`Got Message: ${msg}`)
		const words = msg.split(' ')
		switch (words[0]) {
			case "focusTab":
				browser.tabs.update(parseInt(words[1]), { active: true })
				break;
			case "removeTab":
				browser.tabs.remove(parseInt(words[1]))
				break;
		}
	});
	
	updateTabs()
	browser.tabs.onCreated.addListener(tab => {
		nativePort.postMessage({
			event: 'addTab',
			payload: tab
		})
	})
	browser.tabs.onActivated.addListener(tab => {
		nativePort.postMessage({
			event: 'updateFocused',
			payload: tab.tabId
		})
	})
	browser.tabs.onRemoved.addListener(tabId => {
		nativePort.postMessage({
			event: 'removeTab',
			payload: tabId
		})
	})
	browser.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
		if (!( 'favIconUrl' in tab )) { return }
		nativePort.postMessage({
			event: 'updateTab',
			payload: {
				url: tab.url,
				title: tab.title,
				active: tab.active,
				id: tab.id,
				favIconUrl: tab.favIconUrl
			}
		})	
	})
	// Might not be needed! setInterval(updateTabs, 60 * 1000)
	
	console.log(`Finished setting everything up!`)
})()
