FROM ubuntu

ARG SUSHI_VERSION
ARG FIRELY_TERMIN_VERSION
ARG NODE_VERSION=--lts
ARG DOTNET_VERSION=6.0

RUN apt update && apt install -y software-properties-common

# Add backports for .NET 6
RUN add-apt-repository ppa:dotnet/backports

RUN apt update \
    && apt install -y curl dotnet-sdk-${DOTNET_VERSION}


# Install NodeJS via NVM
ENV NVM_DIR=/root/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install ${NODE_VERSION}

RUN . $NVM_DIR/nvm.sh && npm install --global fsh-sushi@${SUSHI_VERSION}
RUN dotnet tool install --global Firely.Terminal --version ${FIRELY_TERMIN_VERSION}
