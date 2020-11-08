# Firefox Config

References:

- [Firefox Support Article on about:config](https://support.mozilla.org/en-US/kb/about-config-editor-firefox)
  - Mentions that Preference names _are_ case-sensitive
- [mozillaZine wiki on User.js file](http://kb.mozillazine.org/User.js_fil)
- [mozillaZine wiki on locking preferences](http://kb.mozillazine.org/Locking_preferences)
- [mozillaZine wiki on about:* links](http://kb.mozillazine.org/About_protocol_links)


TODO Sources for tweaks:

- [mozillaZine wiki on about:config entries](http://kb.mozillazine.org/About:config_entries)
- [Ghacks article on about:config](https://www.ghacks.net/overview-firefox-aboutconfig-security-privacy-preferences/)
- [Pre-configured user.js that has a ton of good stuff](https://github.com/arkenfox/user.js)
- [Some random thing from google](https://theprivacyguide1.github.io/about_config.html)
- [Archlinux wiki on firefox stuff](https://wiki.archlinux.org/index.php/Firefox/Tweaks#Turn_off_sponsored_content_and_tiles)
  - [More Archlinux wiki](https://wiki.archlinux.org/index.php/Firefox#Tips_and_tricks)
  - [Even more Archlinux wiki](https://wiki.archlinux.org/index.php/Firefox#Configuration)

Done Sources:

- [Some guy's gist that came up in Google](https://gist.github.com/0XDE57/fbd302cef7693e62c769)

## Config

### Grab Bag

Source: <https://www.reddit.com/r/linux/comments/39q6xt/some_useful_firefox_tips_to_fix_choppy_scrolling/>

Increases animation speed, completely eliminated choppy scrolling

```
layout.frame_rate.precise: true
```

Send more than one HTTP request at once to servers. On a proxy too

```
http.networking.pipelining: true
network.http.proxy.pipelining: true
```

Supposed to make it faster?

```
browser.tabs.animate: false
```

Don't wait as long before starting rendering. Create a new integer value:
```
nglayout.initialpaint.delay: 100
```

Don't let websites control our right-click context menu

```
dom.event.contextmenu.enable: false
```

Disable silly builtin extensions

```
app.shield.optoutstudies.enabled: false

# ???
extensions.shield-recipe-client.enabled: false

# This one is kinda cool, let's try it
extensions.screenshots.disabled: true
```

Source: <https://wiki.archlinux.org/index.php/Firefox/Tweaks#Turn_off_sponsored_content_and_tiles>

```
browser.newtabpage.directory.source: blank # Prevent new tab page chatter
browser.newtabpage.directory.ping: blank   # More chatter prevention
```

Source: <http://tuxdiary.com/2014/02/27/firefox-memory-tweaks/>

```
media.autoplay.enabled: false # Don't autoplay media
```

Source: Unknown

I _think_ i added these for privacy:

```
dom.max_script_run_time: 0
app.update.auto: false
app.update.enabled: false
browser.safebrowsing.malware.enabled;false
browser.safebrowsing.phishing.enabled;false
camera.control.face_detection.enabled;false
experiments.activeExperiment;false
geo.enabled;false
geo.wifi.uri;""
media.eme.chromium-api.enabled;false
media.eme.enabled;false
media.gmp-.enabled;false
media.navigator.enabled;false
media.peerconnection.enabled;false
network.http.speculative-parallel-limit;0
network.predictor.cleaned-up;true
network.predictor.enabled;false
network.prefetch-next;false
```

Privacy

```
dom.battery.enabled: false
dom.push.connection.enabled: false
dom.push.enabled: false
dom.webnotifications.enabled: false
dom.webnotifications.serviceworker.enabled: false
beacon.enabled: false
device.sensors.enabled;false
network.dns.disablePrefetch;true
privacy.resistFingerprinting;true
social.directories;""
social.remote-install.enabled;false
social.share.activationPanelEnabled;false
social.shareDirectory;""
social.toast-notifications.enabled;false
stagefright.disabled;false
```

Random

```
browser.bookmarks.restore_default_bookmarks;false
browser.bookmarks.showMobileBookmarks;false
browser.display.background_color;#F6F6F6
extensions.e10sBlockedByAddons;false
extensions.e10s.rollout.hasAddon;true
extensions.e10sMultiBlockedByAddons;true
```

?????

```
browser.newtabpage.enhanced;true
browser.customizemode.tip0.shown;true
browser.search.widget.inNavBar;false
browser.tabs.remote.autostart.2;true
```

Don't check that Firefox is the default browser

```
browser.shell.checkDefaultBrowser; false
```

Turn off datareporting
```
datareporting.healthreport.uploadEnabled; false
datareporting.healthreport.service.enabled; false
datareporting.policy.dataSubmissionEnabled; false
```

### Gist from some guy

Source: <https://gist.github.com/0XDE57/fbd302cef7693e62c769>

Don't allow websites to prevent copy and paste.
Disable notifications of copy, paste, or cut functions.
Stop webpage knowing which part of the page had been selected.

```
dom.event.clipboardevents.enabled: false
```

Show punycode. Help protect from character 'spoofing' eg:
`xn--80ak6aa92e.com -> аррӏе.com`
[IDN homograph attacks](https://www.xudongz.com/blog/2017/idn-phishing/)

```
network.IDN_show_punycode: true
```

Disable site reading installed plugins.
Have to create it.

Note: Why would I _ever_ want this? What does it provide???

```
plugins.enumerable_names: blank
```

Tells website where you came from. Disabling may break some sites.
  0 = Disable referrer headers.
  1 = Send only on clicked links.
  2 = (default) Send for links and image.

```
network.http.sendRefererHeader = 0
```

Disable referrer headers between https websites. Had to create this.

```
network.http.sendSecureXSiteReferrer = false
```

Send fake referrer (if choose to send referrers).

```
network.http.referer.spoofSource = true
```

Mozilla's built in tracking protection. Seems to actually speed shit up and be helpful

```
privacy.trackingprotection.enabled = true
```

Disables geolocation and Firefox logging geolocation requests.

Had to create both the `.url` entries

```
geo.enabled = false
geo.wifi.uri = blank
browser.search.geoip.url = blank
```

Disable Google Safe Browsing and malware and phishing protection.
Stop sending links and downloading lists from google.
Security risk, but privacy improvement.
Note: this list may be incomplete as firefox updates, be sure to search for browser.safebrowsing.provider.google*
Also simply setting safebrowsing.*.enabled to false should make setting the URL's to blank redundant, but better to be safe.
If you see anything pointing google, probably best to nuke it.

NOTE: I didn't set this, it's a choose-your-side world and I'm in bed with Google

```
browser.safebrowsing.enabled = false
browser.safebrowsing.phishing.enabled = false
browser.safebrowsing.malware.enabled = false
browser.safebrowsing.downloads.enabled = false
browser.safebrowsing.provider.google4.dataSharing.enabled = blank
browser.safebrowsing.provider.google4.updateURL = blank
browser.safebrowsing.provider.google4.reportURL = blank
browser.safebrowsing.provider.google4.reportPhishMistakeURL = blank
browser.safebrowsing.provider.google4.reportMalwareMistakeURL = blank
browser.safebrowsing.provider.google4.lists = blank
browser.safebrowsing.provider.google4.gethashURL = blank
browser.safebrowsing.provider.google4.dataSharingURL = blank
browser.safebrowsing.provider.google4.dataSharing.enabled = false
browser.safebrowsing.provider.google4.advisoryURL = blank
browser.safebrowsing.provider.google4.advisoryName = blank
browser.safebrowsing.provider.google.updateURL = blank
browser.safebrowsing.provider.google.reportURL = blank
browser.safebrowsing.provider.google.reportPhishMistakeURL = blank
browser.safebrowsing.provider.google.reportMalwareMistakeURL = blank
browser.safebrowsing.provider.google.pver = blank
browser.safebrowsing.provider.google.lists = blank
browser.safebrowsing.provider.google.gethashURL = blank
browser.safebrowsing.provider.google.advisoryURL = blank
browser.safebrowsing.downloads.remote.url = blank
```

Can call home to every time Firefox is started or home page is visited.
<https://support.mozilla.org/en-US/kb/how-stop-firefox-making-automatic-connections>
<http://kb.mozillazine.org/Connections_established_on_startup_-_Firefox>

NOTE: I didn't set this, telemetry for Firefox is important

```
browser.selfsupport.url = blank
browser.aboutHomeSnippets.updateUrL = blank
browser.startup.homepage_override.mstone = ignore
browser.startup.homepage_override.buildID = blank
startup.homepage_welcome_url = blank
startup.homepage_welcome_url.additional = blank
startup.homepage_override_url = blank
```

Seems no longer relevant? Firefox code resets it when it's invalid?

```
toolkit.telemetry.cachedClientID = blank
```

Prevent website tracking clicks.

```
browser.send_pings = false
```

Only send pings if send and receiving host match (same website).

```
browser.send_pings.require_same_host = true
```

Disable website reading how much battery your mobile device or laptop has.

```
dom.battery.enabled = false
```

Disables acceptance of session cookies.

Note: Did not set, cookies are tasty

```
network.cookie.alwaysAcceptSessionCookies = false
```

Disable cookies.
0 = All cookies are allowed. (Default)
1 = Only cookies from the originating server are allowed. (block third party cookies)
2 = No cookies are allowed.
3 = Third-party cookies are allowed only if that site has stored cookies already from a previous visit
(Added) 4 = Storage access policy: Block cookies from trackers

Note: Did not set, cookies are tasty

```
network.cookie.cookieBehavior
```

Cookies are deleted at the end of the session
0 = The cookie's lifetime is supplied by the server. (Default)
1 = The user is prompted for the cookie's lifetime.
2 = The cookie expires at the end of the session (when the browser closes).
3 = The cookie lasts for the number of days specified by network.cookie.lifetime.days.

Nope.


```
network.cookie.lifetimePolicy
```

Number of cached DNS entries. Lower number = More requests but less data stored.

Nope.

```
network.dnsCacheEntries = 100
```

Time DNS entries are cached in seconds.

Nope.

```
network.dnsCacheExpiration = 60
```

Disables recording of visited websites.

Note: Definitely didn't set, history is key

```
places.history.enabled = false
```

Disables saving of form data.

Note: Didn't set this, form filling is convenient

```
browser.formfill.enable = false
```

Disables caching on hardrive.

Nope.
Note: What? Why??

```
browser.cache.disk.enable = false
```

Disables caching for ssl connections.

Nope.
Note: What? Why??

```
browser.cache.disk_cache_ssl = false
```

Disables caching in memory.

Nope.

```
browser.cache.memory.enable = false
```

Disables offline cache.
Nope.

```
browser.cache.offline.enable = false
```

If your OS or ISP does not support IPv6, there is no reason to have this preference set to false.

Nope.

```
network.dns.disableIPv6 = true
```

Link prefetching is when a webpage hints to the browser that certain pages are likely to be visited,
so the browser downloads them immediately so they can be displayed immediately when the user requests it.

Note: This is super nice, not disabling


```
network.predictor.enabled = false
network.dns.disablePrefetch = true
network.prefetch-next = false
```

Disable prefetch link on hover.

Nope.

```
network.http.speculative-parallel-limit = 0
```

WebSockets is a technology that makes it possible to open an interactive communication
session between the user's browser and a server. (May leak IP when using proxy/VPN)

Sure? Not familiar with what actually uses this
Had to create the `network.websocket.enabled` preference

```
media.peerconnection.enabled = false
network.websocket.enabled = false
```

Disable 3rd party closed-source Hello integration.
Note: only affects older versions of firefox as "Hello" has been discontinued as in favor of webrtc: https://support.mozilla.org/en-US/kb/hello-status

```
loop.enabled = false
```

Disable 3rd party closed-source Pocket integration.
Note, this is browser.pocket.enabled for older versions of firefox

```
extensions.pocket.enabled = false
extensions.pocket.site = blank
extensions.pocket.oAuthConsumerKey = blank
extensions.pocket.api = blank
```

Performance:

Increases animation speed. May mitigate choppy scrolling. Had to create.

```
layout.frame_rate.precise = true
```

Enable Hardware Acceleration and Off Main Thread Compositing (OMTC).
It's likely your browser is already set to use these features.
May introduce instability on some hardware.

Had to create both `.enabled` configs.

```
webgl.force-enabled = true
layers.acceleration.force-enabled = true
layers.offmainthreadcomposition.enabled = true
layers.offmainthreadcomposition.async-animations = true
layers.async-video.enabled = true
html5.offmainthread = true
```

### PCMag stuff

Source: <https://www.pcmag.com/how-to/how-to-customize-firefox-with-the-configuration-editor>

Open bookmarks in a new page, instead of the current tab:

```
browser.tabs.loadBookmarksInTabs: true
```

Open toolbar searches in a new tab too:

```
browser.search.openintab: true
```

Dim the page when searching:

```
findbar.modalHighlight: true
```

Highlight all instances of a search word:

```
findbar.highlightAll: true
```

Change the backspace action:

0 is back to previous tab
1 is up the current page one section at a time
2 is do nothing

```
browser.backspace_action: 2
```

Spellcheck normally only works on multi-line text files not single-line files. You can change that behavior:

2 sets it to any field or form where you enter text

```
layout.spellcheckDefault: 2
```

### Make Tech Easier article
Source: <https://www.maketecheasier.com/28-coolest-firefox-aboutconfig-tricks/>

Lower memory when minimizing window, will need to be created:

```
config.trim_on_minimize: true
```


Increase the disk cache size:

It's in KB. 50000 is the default, which is only 50MB.

```
browser.cache.disk.capacity: ???
```

Always select the entire URL bar contents when you click:

(Defaults to false on linux)

```
browser.urlbar.clickSelectsAll: true
```

Increase the size of the offline cache that supported webapps are allowed to use. Default is 512000, about 500MB, of data:

```
browser.cache.offline.capacity: ????? (in KB)
```

Open the source code view after clicking "view source" to be an external editor:

```
view_source.editor.external: true
view_source.editor.path: path/to/editor
```

## Legacy Electrolysis Stuff

Source: <http://techdows.com/2016/08/firefox-48-e10s-enabled-or-disabled-if-disabled-enable.html>

Enable Electrolysis, only relevant for really old Firefox

```
# Required to enable
browser.tabs.remote.autostart: true
# Forces on Electrolysis regardless of addon compatability. Must create it
browser.tabs.remote.force-enable: true
# Required for Electrolysis, set to 0 by "accessibility tools"
accessibility.force_disabled: 1
```

Source: <https://www.reddit.com/r/github/comments/9ugnwp/github_no_longer_works_with_firefox_58/e95i3nw/>

```
general.useragent.override: 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0'
```

Note: Setting the general useragent didn't work for github, had to set the specific one

```
general.useragent.override.github.com: 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0'
```

With Firefox 52 it blocked non-electrolysis enabled addons by default, I was able to load them with:

```
extensions.e10sBlocksEnabling: false
extensions.legacy.enabled: true
```

ADDON APOCALYPSE

```
xpinstall.signatures.required;false # Don't require signatures...
devtools.chrome.enabled;true  # Command line in browser console
```

Double down on disabling updater

```
app.update.mode; 0
app.update.service.enabled; false
```

## Most Used FF52 Export Preferences

listed about:config preferences via about:support
"Important Modified Preferences" from 'about:config', most from addons:

```
accessibility.force_disabled	1
accessibility.typeaheadfind.flashBar	0
browser.cache.disk.capacity	921600
browser.cache.disk.filesystem_reported	1
browser.cache.disk.hashstats_reported	1
browser.cache.disk.smart_size.enabled	false
browser.cache.disk.smart_size.first_run	false
browser.cache.disk.smart_size.use_old_max	false
browser.cache.frecency_experiment	2
browser.download.importedFromSqlite	true
browser.places.smartBookmarksVersion	8
browser.search.update	false
browser.search.useDBForOrder	true
browser.sessionstore.max_serialize_back	15
browser.sessionstore.max_serialize_forward	10
browser.sessionstore.max_tabs_undo	40
browser.sessionstore.max_windows_undo	4
browser.sessionstore.postdata	1
browser.sessionstore.upgradeBackup.latestBuildID	20170125094131
browser.startup.homepage_override.buildID	20170125094131
browser.startup.homepage_override.mstone	51.0.1
browser.tabs.animate	false
browser.tabs.remote.autostart	true
browser.tabs.remote.autostart.2	true
browser.tabs.remote.force-enable	true
browser.urlbar.suggest.openpage	false
browser.urlbar.suggest.searches	true
browser.urlbar.userMadeSearchSuggestionsChoice	true
dom.apps.lastUpdate.buildID	20161019084923
dom.apps.lastUpdate.mstone	49.0.2
dom.apps.reset-permissions	true
dom.event.contextmenu.enabled	false
dom.mozApps.used	true
dom.push.userAgentID	REDACTED
extensions.lastAppVersion	51.0.1
font.internaluseonly.changed	true
general.autoScroll	false
gfx.blacklist.direct2d.failureid	FEATURE_FAILURE_DL_BLACKLIST_REDACTED
gfx.blacklist.layers.direct3d9.failureid	FEATURE_FAILURE_DL_BLACKLIST_REDACTED
gfx.crash-guard.glcontext.appVersion	45.0.2
gfx.crash-guard.glcontext.deviceID	REDACTED
gfx.crash-guard.status.glcontext	2
media.autoplay.enabled	false
media.benchmark.vp9.fps	209
media.benchmark.vp9.versioncheck	1
media.gmp-gmpopenh264.abi	x86_64-gcc3-u-i386-x86_64
media.gmp-gmpopenh264.enabled	false
media.gmp-gmpopenh264.lastUpdate	1471823355
media.gmp-gmpopenh264.version	1.6
media.gmp-manager.buildID	REDACTED
media.gmp-manager.lastCheck	1486745574
media.gmp-widevinecdm.abi	x86_64-gcc3-u-i386-x86_64
media.gmp-widevinecdm.enabled	false
media.gmp-widevinecdm.lastUpdate	1474658126
media.gmp-widevinecdm.version	1.4.8.903
media.gmp.storage.version.observed	1
media.webrtc.debug.aec_log_dir	/Users/REDACTED/Library/Caches/TemporaryItems
media.webrtc.debug.log_file	/Users/REDACTED/Library/Caches/TemporaryItems/WebRTC.log
media.youtube-ua.override.to	43
network.auth.allow-subresource-auth	2
network.cookie.prefsMigrated	true
network.dns.disablePrefetch	true
network.http.pipelining	true
network.http.proxy.pipelining	true
network.http.speculative-parallel-limit	0
network.predictor.cleaned-up	true
network.prefetch-next	false
places.database.lastMaintenance	1486742005
places.history.expiration.transient_current_max_pages	138231
plugin.disable_full_page_plugin_for_types	application/pdf
plugin.importedState	true
plugin.state.default browser	0
plugin.state.googletalkbrowserplugin	1
plugin.state.java	0
plugin.state.meetingjoinplugin	0
plugin.state.o1dbrowserplugin	1
plugin.state.sharepointbrowserplugin	0
print.print_bgcolor	false
print.print_bgimages	false
print.print_colorspace
print.print_command
print.print_downloadfonts	false
print.print_duplex	1515870810
print.print_evenpages	true
print.print_in_color	true
print.print_margin_bottom	0.5
print.print_margin_left	0.5
print.print_margin_right	0.5
print.print_margin_top	0.5
print.print_oddpages	true
print.print_orientation	0
print.print_page_delay	50
print.print_paper_data	0
print.print_paper_height	11.00
print.print_paper_name
print.print_paper_size_type	1
print.print_paper_size_unit	0
print.print_paper_width	8.50
print.print_plex_name
print.print_resolution	1515870810
print.print_resolution_name
print.print_reversed	false
print.print_scaling	1.00
print.print_shrink_to_fit	true
print.print_to_file	false
print.print_unwriteable_margin_bottom	56
print.print_unwriteable_margin_left	25
print.print_unwriteable_margin_right	25
print.print_unwriteable_margin_top	25
privacy.clearOnShutdown.passwords	false
privacy.cpd.extensions-sessionmanager	false
privacy.cpd.extensions-tabmix	false
privacy.donottrackheader.enabled	true
privacy.sanitize.migrateClearSavedPwdsOnExit	true
privacy.sanitize.migrateFx3Prefs	true
privacy.trackingprotection.introCount	20
services.sync.declinedEngines	tabs,forms,history
services.sync.engine.history	false
services.sync.engine.prefs.modified	true
services.sync.engine.tabs	false
services.sync.lastPing	1486757287
services.sync.lastSync	Fri Feb 10 2017 14:45:34 GMT-0600 (CST)
services.sync.numClients	1
storage.vacuum.last.index	1
storage.vacuum.last.places.sqlite	1484177547
```
