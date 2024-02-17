
# RabbitMQ

## List of Queues with Zero Consumers

```
index="rabbit"  consumers=0 messages!=0  | table _time name messages consumers | stats last by name
```

## Consumers and Messages for Queue over Time

```
index="rabbit" name=G.Event.CarrierProfileOwnership.OwnershipOverridden.v1.CarrierPortalOwnershipOverriddenMessageObserver* | table _time name messages consumers |
```

## Enumerate all indexes relatively efficiently

```
| eventcount summarize=false index=* index=_* | dedup index | fields index
```

## Usage by source type in gigabytes

[Source](https://community.splunk.com/t5/Getting-Data-In/How-do-you-calculate-the-size-of-indexed-data-as-per-source-type/m-p/441638)

```
index=_internal source=*license_usage.log*  type=Usage| eval GB=b/1024/1024/1024 | stats sum(GB) by st
```

## Usage by

```
index=_internal sourcetype=splunkd source=*license_usage.log type=Usage| stats sum(b) as bytes by idx | eval mb=round(bytes/1024/1024,3)
```
