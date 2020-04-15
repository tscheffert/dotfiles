# Windows Tips And Tricks

## Networking

### Updating the network adapter

```
# netsh interface ip set address name="<name>" static <IP> <subnet> <gateway>
netsh interface ip set address name="Ethernet0" static 172.25.16.200 255.255.255.0 172.25.16.1
```

## Clean up start components with DISM

```
Dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
```
