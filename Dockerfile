FROM node:lts

ARG TS_VERSION
ARG RBXTS_VERSION
ARG ROJO_VERSION
ARG LUNE_VERSION

# Development environment installation
## Set environment variables

## Install dependencies
### Install apt-get packages
RUN apt-get update && \
    apt-get install -y build-essential cmake curl git make python3

## Install global npm packages
RUN npm install -g typescript@${TS_VERSION} roblox-ts@${RBXTS_VERSION} rbxts-build@2.4.0

### Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

### Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Verify installations
RUN /bin/bash -c "source $HOME/.cargo/env && node -v && npm -v && tsc -v && cargo --version && git --version"

## Install cargo packages
### Rojo
RUN /bin/bash -c "source $HOME/.cargo/env && cargo install rojo --version ${ROJO_VERSION} --locked"

### Lune
RUN /bin/bash -c "source $HOME/.cargo/env && cargo install lune --version ${LUNE_VERSION}  --locked"
