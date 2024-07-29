FROM ubuntu AS base

ARG FIRELY_TERMINAL_VERSION
ARG NODE_VERSION=20.16.0
ARG DOTNET_VERSION=6.0

# Add backports for .NET 6
RUN apt update && apt install -y software-properties-common
RUN add-apt-repository ppa:dotnet/backports

RUN apt update \
    && apt install -y \
    curl \
    git \
    dotnet-sdk-${DOTNET_VERSION}

# Install NodeJS via NVM
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION

RUN dotnet tool install --global Firely.Terminal --version $FIRELY_TERMINAL_VERSION

COPY check.sh /root/check.sh
RUN chmod a+rx /root

ENV NODE_PATH=$NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:/root/.dotnet/tools:$PATH

ENV PROJECT_DIR=/project
ENV SUSHI_ROOT=.

ENTRYPOINT [ "/root/check.sh" ]


FROM ghcr.io/cybernop/check-fhir-profiles:base

ARG SUSHI_VERSION

RUN . $NVM_DIR/nvm.sh && npm install --global fsh-sushi@$SUSHI_VERSION
