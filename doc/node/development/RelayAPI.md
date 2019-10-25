# VILLASnode Relay API {#node-dev-api-relay}

The VILLASnode relay tool (`villas-relay`) provides a simple HTTP-REST API for querying active sessions and connections,

There exists only a single route `/api/v1` which provides a JSON document about the current state of the relay.

## Example

```
villas-relay &
curl http://127.0.0.1:8088/api/v1
```

```json
{
    "sessions": [
        {
            "identifier": "test_session",
            "uuid": "53f28267-503e-4ad3-be48-13dd064dc04c",
            "connections": [
                {
                    "name": "localhost",
                    "ip": "127.0.0.1",
                    "created": 1554029599,
                    "bytes_recv": 1400,
                    "bytes_sent": 1400,
                    "frames_recv": 68,
                    "frames_sent": 68
                }
            ],
            "created": 1554029599,
            "connects": 1
        }
    ],
    "version": "v0.7.3",
    "hostname": "3c327c762d45",
    "options": {
        "loopback": true,
        "port": 8088,
        "protocol": "live"
    }
}
```
