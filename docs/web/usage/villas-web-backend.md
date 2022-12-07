# villas web-backend {#web-usage-backend}

The `villas-web-backend` starts the VILLASweb backend.

# Usage

``` url="generated/web/usage/villas-web-backend.txt" title="generated/web/usage/villas-web-backend.txt"
2021/06/07 07:50:37 Starting VILLASweb-backend
Usage of villasweb-backend:
  -admin-mail string
    	Initial admin mail address
  -admin-pass string
    	Initial admin password
  -admin-user string
    	Initial admin username
  -amqp-host string
    	If set, use this as host for AMQP broker (default is disabled)
  -amqp-pass string
    	Password for AMQP broker
  -amqp-user string
    	Username for AMQP broker
  -auth-external
    	Use external authentication via X-Forwarded-User header (e.g. OAuth2 Proxy)
  -auth-external-provider-name string
    	A name of the external authentication provider (default "JupyterHub")
  -auth-logout-url string
    	The URL to redirect the user to log out (default "/oauth2/sign_out?rd=https%3A%2F%2Fjupyter.k8s.eonerc.rwth-aachen.de%2Fhub%2Flogout")
  -authexternal-authorize-url string
    	A URL to initiate external login procedure (default "/oauth2/start")
  -config string
    	Path to YAML configuration file
  -contact-mail string
    	EMail of the administrative contact (default "svogel2@eonerc.rwth-aachen.de")
  -contact-name string
    	Name of the administrative contact (default "Steffen Vogel")
  -db-host string
    	Host of the PostgreSQL database (default is /var/run/postgresql for localhost DB on Ubuntu systems) (default "/var/run/postgresql")
  -db-name string
    	Name of the database to use (default is villasdb) (default "villasdb")
  -db-pass string
    	Password of database connection (default is <empty>)
  -db-ssl-mode string
    	SSL mode of DB (default is disable) (default "disable")
  -db-user string
    	Username of database connection (default is <empty>)
  -jwt-expires-after string
    	The time after which the JSON Web Token expires (default "168h")
  -jwt-secret string
    	The JSON Web Token secret (default "This should NOT be here!!@33$8&")
  -mode string
    	Select debug/release/test mode (default is release) (default "release")
  -port string
    	Port of the backend (default is 4000) (default "4000")
  -s3-bucket string
    	S3 Bucket for uploading files
  -s3-endpoint string
    	Endpoint of S3 API for file uploads
  -s3-nossl
    	Use encrypted connections to the S3 API
  -s3-pathstyle
    	Use path-style S3 API
  -s3-region string
    	S3 Region for file uploads (default "default")
  -sub-title string
    	Sub-title shown in the frontend
  -test-data-path string
    	The path to the test data json file (used in test mode) (default "database/testdata.json")
  -title string
    	Title shown in the frontend (default "VILLASweb")```
