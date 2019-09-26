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
app-emulation/nvidia-docker
app-emulation/nvidia-container-runtime
app-emulation/libnvidia-container-bin
virtual/libnvidia-container
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
**/etc/nvidia-container-runtime/config.toml**
```
[nvidia-container-runtime]
debug = "/var/log/nvidia-container-runtime.log"

[nvidia-container-cli]
debug = "/var/log/nvidia-container-runtime-hook.log"
```
