# Development {#web-development}

## Frontend

### Description

The website itself based on the react javascript framework.

### Required
 - NodeJS with npm

### Setup

 - `git clone git@git.rwth-aachen.de:VILLASframework/VILLASweb.git` to copy the project on your computer
 - `cd VILLASweb`
 - `npm install`

### Running

 - `npm start`

This runs the website on your local computer at port 3000.
The backend must be running to make the website work.

## Backend

### Description

The backend for the website based on NodeJS and express.

### Required

 - NodeJS with npm
 - Running MongoDB server
 - Docker

### Setup

 - `git clone git@git.rwth-aachen.de:VILLASframework/VILLASweb-backend.git` to copy the project on your computer
 - `cd VILLASweb-backend`
 - `npm install`

### Development
 
 - Run a MongoDB server and change endpoint in config.json (e.g. with Docker `docker run -d -p 27017:27017 -u mongodb mongo`)
 - `npm start` to run NodeJS locally

### Running

 - `docker build -t villasweb-backend .`
 - `docker-compose up -d`

This runs the backend on your local computer with the required MongoDB server.
