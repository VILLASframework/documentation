# Development {#web-development}

## Frontend

### Attention

Due to legacy the development is done in the 'develop-villas' branch. The code in 'develop' and 'master' are from an old demo.
It is planned to move the 'develop-villas' branch to 'develop' and use the 'master' branch for major versions once the old
demo is not required to be changed.

### Description

The website itself based on the EmberJS javascript framework.

### Required
 - NodeJS with npm
 - bower
 - EmberJS with ember-cli
 - PhantomJS (needed for testing)

### Setup

(The steps are taken from the ember-cli README.md)

 - `git clone -b develop-villas git@git.rwth-aachen.de:VILLASframework/VILLASweb.git` to copy the project on your computer
 - `cd VILLASweb`
 - `npm install`
 - `bower install`

### Running

 - `ember s` (short for `ember server`)

This runs a test webserver with the website on your local computer at port 4200.
The backend must be running to make the website work.

## Backend

### Description

The backend for the website based on NodeJS and express.

### Required

 - NodeJS with npm
 - Running MongoDB server
 - Docker

### Setup

 - `git clone -b develop git@git.rwth-aachen.de:VILLASframework/VILLASweb-backend.git` to copy the project on your computer
 - `cd VILLASweb-backend`
 - `npm install`

### Development
 
 - Run a MongoDB server and change endpoint in config.json (e.g. with Docker)
 - `npm start` to run NodeJS locally

### Running

 - `docker build -t acs/villasweb-backend .``
 - `docker-compose up -d`

This runs the backend on your local computer with the required MongoDB server.
