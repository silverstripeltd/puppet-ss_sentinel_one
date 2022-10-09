# Puppet Sentinel One

Install, configure and register Sentinel One agent with service

## Agent

This will download and install logrhythm from specified URL.

Configuration is done via the `sentinelctl` CLI application installed when the agent package.

This will configure the agent by running the commands:

``` sh
sentinelctl management proxy set <proxy>
sentinelctl management type set server
sentinelctl management token set <site_token>
sentinelctl control enable
sentinelctl control start
```

Once registered and enabled the secret (passphrase) is required to reconfigure and in particular disable/ stop the client. This is only visible via the web interface.

Once the agent is installed, setup and enabled puppet will not be able to reconfigure the agent directly.
