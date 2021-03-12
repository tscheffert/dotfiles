# ClamAV Setup

## Notes

Installation on macOS:

```
brew install clamav
```

Configuration:

```
cp /usr/local/etc/clamav/freshclam.conf{.sample,}
cp /usr/local/etc/clamav/clamd.conf{.sample,}
```

Edit those files to remove the `Example` line or copy an existing config file from somewhere else.

Check all files on the computer, but only display infected files and ring a bell when found:

```
clamscan -r --bell -i /
```

Set up log files for `clamd`:

```
touch /var/log/clamd.log
chmod 600 /var/log/clamd.log
chown clamav /var/log/clamd.log
```

- TODO: <https://github.com/essandess/macOS-clamAV/blob/7c64b7cfd16fa8c9ae5aa72afdfe020b93652ccb/clamd.conf#L193>

## Clamd Scanning

```
clamdscan # Scans working directory
clamdscan ~ # Scans passed directory
clamdscan --fdpass ~ # Scans passed directory with file descriptor passing, making it faster
clamdscan --multiscan --fdpass ~ # Scans passed directory with file descriptor passing, and parallelization making it faster
```
