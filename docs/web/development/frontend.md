# Frontend {#web-development-frontend}

**Code:** https://github.com/VILLASframework/web

## Description

The frontend is built upon [ReactJS](https://facebook.github.io/react/) and [Flux](https://facebook.github.io/flux/).
React is responsible for rendering the UI and Flux for handling the data and communication with the backends. For more information also have a look at REACT.md
Additional libraries are used, for a complete list see the file `package.json`.

## Requirements

- [NodeJS with npm](https://nodejs.org/en/)

## Setup and Running

```shell
git clone --recursive https://github.com/VILLASframework/web.git
cd web
npm install
npm start
```

This runs the development server for the website on your local computer at port 3000.
The backend must be running to make the website work. 
Type `http://localhost:3000/` in the address field of your browser to open the website.
