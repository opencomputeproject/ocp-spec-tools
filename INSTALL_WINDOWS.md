# Windows installation of Docker

TCG publishes a Docker container to make installation easier.

A manual installation would require understanding the complexities of various Pandoc and LaTeX dependencies.

On a system running Windows, the overall flow is:
1. On Windows, install WSL (with Ubuntu) and Docker
2. On Ubuntu, clone the repository and pull the Docker tooling

These steps are described in detail, below.

## Install Windows Subsystem for Linux (WSL)

1. On the Windows desktop, open the Microsoft Store app
2. In the app, search for "WLS" or "Ubuntu"
3. Install Ubuntu
   - This will install Ubuntu running as a WLS (Window Linux Subsytem) instance
   - "Ubuntu 24.04.1 LTS" was used to validate this README

## Install Docker

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

Finally, proceed to run the [shell commands](./README.md#how-to-run-locally) detailed in the README.
