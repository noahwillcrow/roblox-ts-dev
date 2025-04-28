FROM node:lts

# Development environment installation
## Set environment variables

## Install dependencies
### Install apt-get packages
RUN apt-get update && \
    apt-get install -y build-essential cmake curl git make python3

## Install global npm packages
RUN npm install -g typescript@5.5.3 roblox-ts@3.0.0 rbxts-build@2.4.0

### Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

### Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Verify installations
RUN /bin/bash -c "source $HOME/.cargo/env && node -v && npm -v && tsc -v && cargo --version && git --version"

## Install cargo packages
### Rojo
RUN /bin/bash -c "source $HOME/.cargo/env && cargo install rojo --version 7.4.4 --locked"

### Lune
RUN /bin/bash -c "source $HOME/.cargo/env && cargo install lune --version 0.9.0  --locked"
