# macOS Snippets

## Flush DNS

Should work on OSX 15, Catalina

```
sudo killall -HUP mDNSResponder
sudo killall mDNSResponderHelper
sudo dscacheutil -flushcache
```
