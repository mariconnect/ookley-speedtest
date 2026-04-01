## Build image
```bash
docker build -t ookla-speedtest .
```

## Create network
```bash
docker network create ooklay-speedtest
```

## Run
```bash
docker run --rm --network ooklay-speedtest ookla-speedtest
```