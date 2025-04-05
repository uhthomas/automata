# Eclipse Mosquitto

[https://github.com/eclipse-mosquitto/mosquitto](https://github.com/eclipse-mosquitto/mosquitto)

## Authentication

Authentication is manged with the standard password file. New passwords can be
added by generating a new hash with `mosquitto_passwd`.

```sh
mosquitto_passwd -c out someusername
```
