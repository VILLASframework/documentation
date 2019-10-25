# Production {#web-production}

For setup instructions see @ref web-development.

### Automated

Build the images of the frontend and backend:
 - `cd VILLASweb`
 - `docker build -t villas-web .`
 - `cd ..\VILLASweb-backend`
 - `docker build -t villas-backend .`

Run the producation docker-compose file:
 - `docker-compose -f docker-compose-production.yml up -d`

### Manual

## Frontend

 - `npm run build` Build the static website for production into dist/

All files in build/ must be served by the webserver. The backend endpoint must be available under /api (e.g. via a proxy).

## Backend

The MongoDB and NodeJS backend may be run with docker (same as development). If the database is on another server as the backend, the endpoint
must be changed in config.json. 
