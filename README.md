# SteamCMD Docker Image

## Usage

### Run with interactive shell

```shell
docker run --entrypoint /bin/bash -it vlutz/steamcmd
```

### Download Valheim

```shell
docker run vlutz/steamcmd +login anonymous +app_update 896660 +quit
```

### Download Valheim to volume

```shell
docker run -it -v valheim-files:/home/steam/valheim vlutz/steamcmd +login anonymous +force_install_dir /home/steam/valheim +app_update 896660 +quit
```

### Download Valheim to host directory

```shell
docker run -it -v $(pwd)/valheim-files:/home/steam/valheim vlutz/steamcmd +login anonymous +force_install_dir /home/steam/valheim +app_update 896660 +quit
```
