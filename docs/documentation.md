# Writing Documentation

The VILLASframework documentation is built using [Docusaurus 2](https://docusaurus.io/), a modern static website generator.

### Local Development

#### Using Docker

```
$ make dev
```

### Using Devcontainers

1. Clone repo in [Visual Studio Code](https://visualstudio.microsoft.com/de/)
2. Reopen workspace in Devcontainer: `> Devcontainers: Reopen in Container`

### Directly with Yarn

#### Install

```
$ yarn
```

#### Develop

```
$ yarn start
```

This command starts a local development server and opens up a browser window. Most changes are reflected live without having to restart the server.

#### Build

```
$ yarn build
```

This command generates static content into the `build` directory and can be served using any static contents hosting service.

### Deployment

```
$ make deploy
```
