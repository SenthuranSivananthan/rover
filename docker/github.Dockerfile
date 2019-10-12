ARG versionAzureCli

FROM mcr.microsoft.com/azure-cli:${versionAzureCli}

ARG versionTerraform

RUN apk update \
    && apk add bash jq unzip git

RUN echo "Installing terraform ${versionTerraform}..." \
    && curl -LO https://releases.hashicorp.com/terraform/${versionTerraform}/terraform_${versionTerraform}_linux_amd64.zip \
    && unzip -d /usr/local/bin terraform_${versionTerraform}_linux_amd64.zip \
    && rm terraform_${versionTerraform}_linux_amd64.zip


WORKDIR /tf

COPY . .
RUN git clone https://github.com/aztfmod/landingzones.git /tf/landingzones
RUN git clone https://github.com/aztfmod/level0.git /tf/level0

ENTRYPOINT [ "./launchpad.sh" ]