# Firefox Plugin Requirements

## Need to have

### uBlock Origin

Duh

Also installed uBlock Matrix and set it to "allow-all/block-exceptionally" mode

### Session Manager

- Backup config
- Save multiple sessions
- All windows
- Plays nice with panorama/tab groups

#### Testing

- Tab Session manager
  - Choose this because he directly cites legacy addon Session Manager as inspiration
  - Supports legacy `.session` sessions
  - <https://addons.mozilla.org/en-US/firefox/addon/tab-session-manager/>
  - Required enabling IndexedDB
    - Set `dom.indexedDB.experimental` and `dom.indexedDB.storageOption.enabled` to true from false
  - Mucked around with settings

### Tab Groups

- Panorama mode
- Groups of tabs
- One window, multiple "views" or facets

- Also considered:
- [Simple Tab Groups](https://addons.mozilla.org/en-US/firefox/addon/simple-tab-groups/)

#### Choice: Panorama Tab Groups

- Cause it's been updated in the last three months and seems to work well
- The hotkeys for ctrl+shift+e or alt shift e or whatever I'm used to doesn't work well

- Should consider Simple Tab Groups too
  - <https://addons.mozilla.org/en-US/firefox/addon/simple-tab-groups/>

### Tab Improvements

- Rows
  - Supposedly will have to do this via user chrome changes
- Customize Tab behavior
  - Open at end or adjacent to tab that opened it
  - Remember history for closed/restored tabs

### Tampermonkey

compare with GreaseMonkey and ViolentMonkey

Violent Monkey

- Cross Browser
- Supports syncing with a number of tools
- Terrible documentation and shit

- But what scripts?

### Compact Dark Style

Built in

## Maybe?

### Reddit Enhancement Suite

### Suspend tabs

- Similar to "The Great Suspender", if I haven't browsed it for awhile then suspend it
- Please don't fuck with sessions or groups

### User Style Stuff

Stylish or Stylus?
- Stylish: <https://addons.mozilla.org/en-US/firefox/addon/stylish/>
- Stylus: <https://addons.mozilla.org/en-US/firefox/addon/styl-us/>

- Stylus says that it is:
  - Updated fork from Stylish
  - Removes analytics and tracking
  - Fully compatible with everyone UserStyles

- Styling Firefox UI:
  - <https://github.com/openstyles/stylus/wiki/Styling-Firefox-UI>
  - <https://github.com/Aris-t2/CustomCSSforFx/issues/2#show_issue>
- reStyle might be necessary for Firefox styles:
  - <https://addons.mozilla.org/en-US/firefox/addon/re-style/>

## Installed 2020-06-25

- Grammarly
  - Grammar editting and reviewing
  - Requires login for a bunch of stuff which blows
  - Compare with: <https://addons.mozilla.org/en-US/firefox/addon/languagetool/>
- Tranquility Reader
  - Gets rid of all the crap
  - <https://addons.mozilla.org/en-US/firefox/addon/tranquility-1/>
- View Image
  - Returns the view image button to google images
  - <https://addons.mozilla.org/en-US/firefox/addon/view-image/>
- Vimium
  - <https://addons.mozilla.org/en-US/firefox/addon/vimium-ff>
- Https Everywhere
  - Forces Https everywhere
  - Seems powerful and doesn't impact shit
  - <https://addons.mozilla.org/en-US/firefox/addon/https-everywhere/?src=featured>
- ClearURLS
  - Gets rid of the tracking BS from URLs
  - <https://addons.mozilla.org/en-US/firefox/addon/clearurls/?src=featured>
  - Is this better than `Neat URL`?
    - Logo is worse at least
    - <https://addons.mozilla.org/en-US/firefox/addon/neat-url/>
    - Seen people mention ClearURLs is better

- Decentraleyes
  - Redirects CDN requests to local storage
  - <https://addons.mozilla.org/en-US/firefox/addon/decentraleyes/>

- Added AMP2HTML for amp redirects
  - <https://addons.mozilla.org/en-GB/firefox/addon/amp2html/>

- Added webannoyances ultralist to uBlock Origin
  - <https://github.com/yourduskquibbles/webannoyances>

## Configuration done 2020-11-08

- `layout-frame_rate_precise` was not present
- Set `privacy.trackingprotection.enabled: true` was present but not enabled
- `http.pipelining*` was not present
- Did set

```
extensions.pocket.enabled: false
dom.event.clipboardevents.enabled: false
network.IDN_show_punycode: true
plugins.enumerable_names: blank
network.http.sendRefererHeader = 0
network.http.sendSecureXSiteReferrer = false
network.http.referer.spoofSource: true
geo.enabled = false
geo.wifi.uri = blank
browser.search.geoip.url = blank
browser.send_pings.require_same_host: true
dom.battery.enabled = false
media.peerconnection.enabled = false
network.websocket.enabled = false

extensions.pocket.site = blank
extensions.pocket.oAuthConsumerKey = blank
extensions.pocket.api = blank

webgl.force-enabled = true
layers.acceleration.force-enabled = true
layers.offmainthreadcomposition.enabled = true
layers.offmainthreadcomposition.async-animations = true
layers.async-video.enabled = true
html5.offmainthread = true
```
