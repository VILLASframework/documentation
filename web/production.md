# Production

For setup instructions see development.md

## Frontend

 - `ember build -prod` Build the static website for production into dist/

All files in dist/ must be served by the NGinX webserver. The backend endpoint must be changed in config/environment.js (API_HOST) to match the
production backend endpoint (which should be proxied through the webserver).

## Backend

The MongoDB and NodeJS backend may be run with docker (same as development). If the database is on another server as the backend, the endpoint
must be changed in config.json. 
