# Authentication {#web-authentication}

## External

Uses [OAuth2 Proxy](https://oauth2-proxy.github.io/). For details, checkout the VILLAS HELM chart.

@htmlonly
<div class="mermaid">
sequenceDiagram
    note over VILLASweb_frontend: check if JWT exists
    alt no JWT exists in browser
    VILLASweb_frontend->>+VILLASweb_backend: GET villas.k8s/api/authenticated?
    VILLASweb_backend-->>-VILLASweb_frontend: authenticated = false<br />mode=external<br/>login_url=villas.k8s/oauth2/start
    note over VILLASweb_frontend: Frontend shows link to login URL<br>User clicks on login button
    VILLASweb_frontend->>OAuth2_proxy: GET villas.k8s/oauth2/start?next=...
    note over OAuth2_proxy: does user session exist?<br>(based on Cookie)
    OAuth2_proxy-->>VILLASweb_frontend: Location: jupyter.k8s/hub/api/oauth2/authorize?redirect_url=...
    VILLASweb_frontend->>JupyterHub: GET jupyter.k8s/hub/api/oauth2/authorize?redirect_url=...
    note over JupyterHub: Asks user to log in<br/>after successful login
    JupyterHub-->>VILLASweb_frontend: Location: villas.k8s/oauth2/callback?code=XXXXX
    VILLASweb_frontend->>OAuth2_proxy: GET villas.k8s/oauth2/callback?code=XXXXX
    OAuth2_proxy->>JupyterHub: POST jupyer.k8s/hub/api/oauth2/token?code=XXXXX
    note over JupyterHub: validates code=XXXXX
    JupyterHub-->>OAuth2_proxy: token=YYYYYY
    note over OAuth2_proxy: associate Cookie with valid session
    OAuth2_proxy->>JupyterHub: GET jupyter.k8s/hub/api/oauth2/validate<br>Authorization: Bearer YYYYYY
    JupyterHub-->>OAuth2_proxy: user=...,email=...,groups=...
    note over OAuth2_proxy: validates user
    OAuth2_proxy-->>VILLASweb_frontend: Location: ${next}

    VILLASweb_frontend->>OAuth2_proxy: POST villas.k8s/api/authenticate
    OAuth2_proxy->>VILLASweb_backend: POST villas.k8s/api/authenticate<br/>X-Forwarded-User: svg
    VILLASweb_backend-->>OAuth2_proxy: jwt=...
    OAuth2_proxy-->>VILLASweb_frontend: jwt=...
    note over VILLASweb_frontend: store JWT in Browser

    else JWT exist
    VILLASweb_frontend->>VILLASweb_backend: GET villas.k8s/api/users<br>Authorization: Bearer JWT
    VILLASweb_backend-->>VILLASweb_frontend: users=[...]
    end
</div>
@endhtmlonly
