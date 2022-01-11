# API {#node-dev-api}

VILLASnode can be controlled remotely with an Application Programming Interface (API).
Using this API VILLASnode can be completly remote controlled.

There are two components which provide dedicated APIs:

- VILLASnode daemon: `villas-node`
- VILLASnode relay: `villas-relay`

## API specification

- [**OpenAPI 3.0 Specification**](https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/doc/openapi.yaml)
- Python Wrapper: [Source](https://git.rwth-aachen.de/acs/public/villas/node/-/tree/master/python), [PyPi package](https://pypi.org/project/villas-node/)
   - Install it via: `pip install villas-node`

## Security

**IMPORTANT NOTICE:** The VILLASnode API currently has no support for authentication an authorization.

Do not expose the API endpoint unprotected to untrusted users or the public internet as attackers can exploit the API to gain access to the system running VILLASnode by crafting malicious configurations.

We recommend to hide the VILLASnode API behind an [API gateway](https://www.nginx.com/learn/api-gateway/) or authentication reverse proxy like [OAuth Proxy 2](https://oauth2-proxy.github.io/oauth2-proxy/).

## CURL Examples

### VILLASnode daemon

```bash
villas-node &
curl http://localhost:8080/api/v2/status
{
    "state": "running",
    "version": "v0.10.0",
    "release": "1.docker_multiplatform_release.20201112gitf9ca0f9",
    "build_id": "v0.10.0-f9ca0f9-release",
    "build_date": "20201112",
    "hostname": "ernie",
    "uuid": "c9d64cc7-c6e1-4dd4-8873-126318e9d42c",
    "time_now": 1605194136.9059792,
    "time_started": 1605194127.0170822,
    "timezone": {
        "name": "CEST",
        "offset": -3600,
        "dst": true
    },
    "kernel": {
        "sysname": "Linux",
        "nodename": "ernie",
        "release": "5.6.17-rt10",
        "version": "#5 SMP Fri Jul 10 14:02:33 CEST 2020",
        "machine": "x86_64",
        "domainname": "(none)"
    },
    "system": {
        "cores_configured": 28,
        "cores": 28,
        "procecces": 620,
        "uptime": 1481743,
        "load": [
            3.4453125,
            1.15478515625,
            0.40673828125
        ],
        "ram": {
            "total": 269994606592,
            "free": 253992665088,
            "shared": 44187648,
      16:15:36       "buffer": 565727232
        },
        "swap": {
            "total": 4294963200,
            "free": 4294963200
        },
        "highmem": {
            "total": 0,
            "free": 0
        }
    }
}
```

### VILLASnode relay

```bash
villas-relay &
curl localhost:8088/api/v1
{
    "sessions": [],
    "version": "v0.10.0",
    "hostname": "ernie",
    "uuid": "c9d64cc7-c6e1-4dd4-8873-126318e9d42c",
    "options": {
        "loopback": false,
        "port": 8088,
        "protocol": "live"
    }
}
```
