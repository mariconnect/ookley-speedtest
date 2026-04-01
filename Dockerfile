FROM debian:stable-slim

RUN apt-get update && apt-get install -y curl ca-certificates jq gnupg \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash \
 && apt-get update \
 && apt-get install -y speedtest \
 && rm -rf /var/lib/apt/lists/*

CMD speedtest --accept-license --accept-gdpr -f json 2>/dev/null | jq