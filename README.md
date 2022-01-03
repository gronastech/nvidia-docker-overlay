# nvidia-docker-overlay
Gentoo ebuilds of the https://github.com/NVIDIA/nvidia-docker
### Currenly works only as nvidia-docker2:

```
docker run nvidia/cuda:9.0-base nvidia-smi
```
New configuration
```
docker run --gpus all,capabilities=utility nvidia/cuda:9.0-base nvidia-smi
```
still not supported


You can add this repository to locally installed list typing:
```
layman -f -o https://raw.githubusercontent.com/gronastech/nvidia-docker-overlay/master/repositories.xml -a nvidia-docker-overlay
```

Packages that need to be installed:
```
app-containers/nvidia-docker
app-containers/nvidia-container-runtime
app-containers/nvidia-container-toolkit
app-containers/libnvidia-container-bin
virtual/libnvidia-container
```

However, nvidia-docker will pull all the necessary dependencies so you can simply:

```
emerge nvidia-docker
```

### Configuration files that need to be verified:

**/etc/docker/daemon.json**
```
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    },
    "default-runtime": "nvidia"
}
```

If you are a virtualgl user you might want to change the group in the following
config file:

**/etc/nvidia-container-runtime/config.toml**
```
disable-require = false
#swarm-resource = "DOCKER_RESOURCE_GPU"
#accept-nvidia-visible-devices-envvar-when-unprivileged = true
#accept-nvidia-visible-devices-as-volume-mounts = false

[nvidia-container-cli]
#root = "/run/nvidia/driver"
#path = "/usr/bin/nvidia-container-cli"
environment = []
#debug = "/var/log/nvidia-container-toolkit.log"
#ldcache = "/etc/ld.so.cache"
load-kmods = true
#no-cgroups = false
user = "root:video"
ldconfig = "@/sbin/ldconfig"

[nvidia-container-runtime]
#debug = "/var/log/nvidia-container-runtime.log"
```

Uncomment any debug log lines as needed.

### Verifying your installation

Afterwards verify that everything works by running either:

```
nvidia-docker run -it --rm nvidia/cuda nvidia-smi
```

or

```
docker run -it --rm --runtime=nvidia nvidia/cuda nvidia-smi
```

or if you are using the nvidia runtime as default:

```
docker run -it --rm nvidia/cuda nvidia-smi
```
