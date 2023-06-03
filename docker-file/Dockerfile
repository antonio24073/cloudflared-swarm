FROM ubuntu:latest

# updates
RUN apt update && apt upgrade -y

# dependencies
RUN apt install wget -y

# cloudflared
RUN wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && dpkg -i cloudflared-linux-amd64.deb

# debug tools
RUN apt install curl -y

ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
