## Build image
```bash
docker build -t ookla-speedtest .
```
If it's failing to download, check the Docker Firewall

## Create network
```bash
docker network create ooklay-speedtest
```

## Run
Default output is formatted JSON for human reading:
```bash
docker run --rm --network ooklay-speedtest ookla-speedtest
```

Use raw for compact JSON output for machine parsing:
```bash
docker run --rm --network ooklay-speedtest ookla-speedtest raw
```
