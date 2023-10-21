# Start from the latest Ubuntu image
FROM ubuntu:latest

# Set non-interactive mode for apt-get (to avoid prompts)
ENV DEBIAN_FRONTEND=noninteractive

# Update and install sudo, coreutils, and curl
RUN apt-get update && \
  apt-get install -y \
  sudo \
  coreutils \
  curl \
  git \
  wget && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /bootstrap
COPY . /bootstrap

RUN chmod +x /bootstrap/bootstrap.sh
ENTRYPOINT ["/bootstrap/bootstrap.sh"]
