FROM debian:stable-slim

RUN apt-get update && apt-get install -y curl ca-certificates jq gnupg \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash \
 && apt-get update \
 && apt-get install -y speedtest \
 && rm -rf /var/lib/apt/lists/*

RUN printf '%s\n' \
'#!/bin/sh' \
'set -eu' \
'FILTER='"'"'{download_Mbps: ((.download.bandwidth * 8 / 1000000 * 100 | round) / 100), upload_Mbps: ((.upload.bandwidth * 8 / 1000000 * 100 | round) / 100), packetLoss: (.packetLoss // 0), server: .server.name, location: .server.location, country: .server.country, isp: .isp, result_url: .result.url}'"'"'' \
'mode="${1:-pretty}"' \
'if [ "$mode" = "raw" ]; then' \
'  speedtest --accept-license --accept-gdpr -f json 2>/dev/null | jq -c -M "$FILTER"' \
'else' \
'  speedtest --accept-license --accept-gdpr -f json 2>/dev/null | jq  -C "$FILTER"' \
'fi' \
> /usr/local/bin/run-speedtest \
 && chmod +x /usr/local/bin/run-speedtest

ENTRYPOINT ["/bin/sh", "/usr/local/bin/run-speedtest"]
CMD ["pretty"]
