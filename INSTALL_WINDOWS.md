# Introduction

TCG publishes a Docker container to make installation easier.

A manual installation would require understanding the complexities of various Pandoc and LaTeX dependencies.

On a system running Windows, the overall flow is:
1. On Windows, install WSL (with Ubuntu) and Docker Desktop
2. On Ubuntu, clone the repository and pull the Docker tooling

These steps are described in detail, below.

## Install Windows Subsystem for Linux (WSL)

1. On the Windows desktop, open the Microsoft Store app
2. In the app, search for "WLS" or "Ubuntu"
3. Install Ubuntu
   - This will install Ubuntu running as a WLS (Window Linux Subsytem) instance
   - "Ubuntu 24.04.1 LTS" was used to validate this README

## Install Docker Desktop

1. On the Windows desktop, open the Microsoft Store app
2. In the app, search for "docker"
3. Install "Docker Desktop"
    - A license for Docker Desktop may need to be obtained.

In lieu of Docker Desktop, the Docker daemon can be manually installed, by running these commands:

```
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Test that Docker is installed by running:

```
sudo docker run hello-world
```

## Clone the repository and pull tooling

1. Get the path to the repository
    - In a browser, go to https://github.com/opencomputeproject/ocp-spec-tools
    - In the 'Code' dropdown, click the icon for "copy URL to clipboard"
2. On the Windows desktop, open the WLS app.
    - This will launch a Command Window for Ubuntu
    - The prompt will be at the home directory (~)
3. Execute the following command, where the \<URL\> is pasted from the clipboard

```
    git clone \<URL\>
```

4. Pull the docker files

```
    cd ocp-spec-tools
    ./docker-pull.sh
```

## Convert test document

The docker-run.sh commad must be run from the directory containing the input file

```
    cd sample-spec
    ../docker-run.sh --pdf spec.pdf spec.ocp
```

The resulting file (spec.pdf) is placed in the current directory

