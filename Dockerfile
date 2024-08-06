FROM ubuntu AS base

ARG FIRELY_TERMINAL_VERSION
ARG NODE_VERSION=20.16.0
ARG DOTNET_VERSION=6.0

RUN apt update \
    && apt install -y \
    curl \
    wget \
    git \
    # .NET dependencies
    ca-certificates \
    libc6 \
    libgcc-s1 \
    libgssapi-krb5-2 \
    libicu74 \
    liblttng-ust1 \
    libssl3 \
    libstdc++6 \
    libunwind8 \
    zlib1g

# Install .NET SDK
RUN wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh \
    && chmod +x ./dotnet-install.sh \
    && ./dotnet-install.sh --channel ${DOTNET_VERSION} \
    && rm ./dotnet-install.sh

ENV DOTNET_ROOT=/root/.dotnet
ENV PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

# Install NodeJS via NVM
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION

ENV NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install the Firely Terminal
RUN dotnet tool install --global Firely.Terminal --version $FIRELY_TERMINAL_VERSION

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod a+rx /root

ENV PROJECT_DIR=/project
ENV SUSHI_ROOT=.

ENTRYPOINT [ "/root/entrypoint.sh" ]


FROM ghcr.io/cybernop/check-fhir-profiles:base

ARG SUSHI_VERSION

# Install FSH sushi
RUN . $NVM_DIR/nvm.sh && npm install --global fsh-sushi@$SUSHI_VERSION
