# VILLASnode API {#node-dev-api-node}

VILLASnode can be controlled remotely with an Application Programming Interface (API).
Using this API VILLASnode can be completly remote controlled.

## Security

**IMPORTANT NOTICE:** The VILLASnode API currently has no support for authentication an authorization.

Do not expose the API endpoint unprotected to untrusted users or the public internet as attackers can exploit the API to gain access to the system running VILLASnode by crafting malicious configurations.

We recommend to hide the VILLASnode API behind an [API gateway](https://www.nginx.com/learn/api-gateway/) or authentication reverse proxy like [OAuth Proxy 2](https://oauth2-proxy.github.io/oauth2-proxy/).

## API specification

- [OpenAPI 3.0 Specification](https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/doc/openapi.yaml)
- Python Wrapper: [Source](https://git.rwth-aachen.de/acs/public/villas/node/-/tree/master/python), 
   - Install it via: `pip install villas-node`

## CURL Example

```
curl http://localhost:8080/api/v2/status
```
