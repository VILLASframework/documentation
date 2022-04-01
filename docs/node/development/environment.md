---
sidebar_label: Environment
sidebar_position: 2
---

# Development Environment

This page describes the setup of a recommended development environment.
To simplify the setup, the development environment will run inside a Docker container.
We use Microsofts free Visual Studio Code editor and its [_Development Container_](https://code.visualstudio.com/docs/remote/containers) feature for managing and connecting to this container.

VILLASnode comes with a pre-configured [`devcontainer.json`](https://git.rwth-aachen.de/acs/public/villas/node/-/blob/master/.devcontainer/devcontainer.json) file.

:::note
The page roughly follows the tutorial from Microsoft on this topic: [Remote development in containers](https://code.visualstudio.com/docs/remote/containers-tutorial).
:::

Alternatively, we provide just a Docker image containing all development dependency which can be used alone without Visual Studio Code at via:

```bash
docker run --privileged registry.git.rwth-aachen.de/acs/public/villas/node/dev:master
```

## Requirements

- [Git](https://git-scm.com/downloads/)
- [Docker Desktop](https://docs.docker.com/desktop/windows/install/)
- [Microsoft Visual Studio Code](https://code.visualstudio.com/)
    - Including [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension

## Setup

1. Install https://git.rwth-aachen.de/acs/public/villas/node.git, [Docker Desktop](https://docs.docker.com/desktop/windows/install/) and [Microsoft Visual Studio Code](https://code.visualstudio.com/)
1. Start Docker
1. Start Visual Studio
1. Install the the [Remote - Containers](vscode:extension/ms-vscode-remote.remote-containers) extension.
1. Clone the VILLASnode source code or open an existing folder containing it:
    - `Ctrl+Shift+P` → `Git: clone` → `https://git.rwth-aachen.de/acs/public/villas/node.git`
    - When asked `Would you like to open the cloned repository?` click on `Open`
    - When asked `Select a kit for node` press `Esc`
1. Re-open in development container:
    - `Ctrl+Shift+P` → `Remote-Containers: Reopen in Container`
1. Build VILLASnode
    - `Ctrl+Shift+P` → `CMake: Build`

Both Microsoft's CMake and C++ Tools extensions are installed automatically and allow you to build and debug the C++ source code via [Visual Studios Code's standard procedure](https://code.visualstudio.com/docs/cpp/cpp-debug).
