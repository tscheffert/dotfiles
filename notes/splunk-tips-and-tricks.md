
# RabbitMQ

## List of Queues with Zero Consumers

```
index="rabbit"  consumers=0 messages!=0  | table _time name messages consumers | stats last by name
```

## Consumers and Messages for Queue over Time

```
index="rabbit" name=G.Event.CarrierProfileOwnership.OwnershipOverridden.v1.CarrierPortalOwnershipOverriddenMessageObserver* | table _time name messages consumers |
```
