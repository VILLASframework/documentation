# Getting started guide {#node-guide}

## Installation

We put some effort in getting you started as smooth as possible.

For first tests and development you can use the Docker platform to bootstrap your environment.
Docker is a software to run containers (a.k.a images in Docker's terminology) on a Linux machine.
We use for development as well as for testing or demonstrating VILLASnode's functionality.

**Note:** We do not recommend to use Docker for running VILLASnode in a real-time simulation.

We prepared a image which you can download and run out of the box:

1. Download the Docker toolbox: https://www.docker.com/docker-toolbox.
    This toolbox includes a virtual machine as well all the Docker tools you need to the Docker container which is provided by us.
     More instructions to get with can be found here: http://docs.docker.com/windows/started/
 
    ![Download Docker Tollbox](docker_toolbox_download.png)
 
2. Install the Docker Toolbox by following the instructions of the installer:

    ![Install Docker Toolbox 1](docker_toolbox_installer_1.png)
    ![Install Docker Toolbox 2](docker_toolbox_installer_2.png)
    ![Install Docker Toolbox 3](docker_toolbox_installer_3.png)
    ![Install Docker Toolbox 4](docker_toolbox_installer_4.png)
    ![Install Docker Toolbox 5](docker_toolbox_installer_5.png)
    ![Install Docker Toolbox 6](docker_toolbox_installer_6.png)
    ![Install Docker Toolbox 7](docker_toolbox_installer_7.png)

3. After the installation finished, open the "Docker Quickstart Terminal".  
    During the first startup, Docker will provision a VirtualBox VM to run the VILLASnode Docker image:

   ![Provision of Docker Machine during first startup.](docker_machine_provisioning.png)

4. One the provisioning completed, you will be greeted with a command line prompt:  

    ![Docker Quickstart Terminal.](docker_terminal.png)

5. Download the latest VILLASnode Docker image by runnning: `$ docker pull villas/node`  

   ![Pulling VILLASnode Docker image.](docker_pull.png)

6. Test VILLASnode image by running: `$ docker run villas/node node -h`

   ![Running VILLASnode Docker image.](docker_run.png)

7. Enter an interactive VILLASnode shell by running: ``$ docker run --tty --interactive --entrypoint bash villas/node``

    ![Docker run VILLASnode interactively](docker_run_interactive.png)

**Please note:** the rest of this guide can be completed in this interactive shell.

```
$ docker run villas/node node --help
```

@htmlonly
<script type="text/javascript" src="https://asciinema.org/a/dxahz9czmz2n5yh31rzctmhwj.js" id="asciicast-dxahz9czmz2n5yh31rzctmhwj" async></script>
@endhtmlonly
