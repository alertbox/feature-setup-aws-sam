#!/usr/bin/env bash

# The 'install.sh' entrypoint script is always executed as the root user.
#
# This script installs AWS SAM CLI.
# Source: https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html#install-sam-cli-instructions

set -e

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -qq
        fi
        apt-get -qq install --no-install-recommends "$@"
        apt-get clean
    fi
}

# Set non-interactive frontend to avoid prompts
export DEBIAN_FRONTEND=noninteractive

# Set version from environment variable or default to "latest"
VERSION="${VERSION:-latest}"

echo "Activating feature 'sam'"

# Clean up package lists before installation
rm -rf /var/lib/apt/lists/*

# Install required dependencies
check_packages curl ca-certificates gnupg2 dirmngr unzip

# Determine system architecture and set build type
ARCH="$(dpkg --print-architecture)"
case "${ARCH}" in
    amd64)  BUILD="x86_64" ;;
    arm64)  BUILD="arm64" ;;
    *)      echo "error: unsupported architecture: ${ARCH}"; exit 1 ;;
esac

# Process version information and construct download URL components
case "${VERSION}" in
    latest | v*)  TAG="${VERSION}" ;;
    *)            TAG="v${VERSION}" ;;
esac

case "${TAG}" in
    latest)  RELEASE="latest/download" ;;
    *)       RELEASE="download/${TAG}" ;;
esac

# Set installation paths and filenames
INSTALL_DIR="aws-sam-cli"
ZIP="aws-sam-cli-linux-${BUILD}.zip"

# Download AWS SAM CLI package
# Example URL: https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-arm64.zip
echo "Downloading AWS SAM CLI version ${TAG}..."
curl "https://github.com/aws/aws-sam-cli/releases/${RELEASE}/${ZIP}" \
    -fsSLO \
    --compressed \
    --retry 5 || \
    { echo "error: failed to download: ${TAG}"; exit 1; }

# Extract the package
echo "Extracting AWS SAM CLI..."
unzip "${ZIP}" -d "${INSTALL_DIR}" || \
    { echo "error: failed to unzip ${ZIP}"; exit 1; }

# Install AWS SAM CLI
echo "Installing AWS SAM CLI..."
su "${_REMOTE_USER}" -c "./${INSTALL_DIR}/install" || \
    { echo "error: failed to install sam"; exit 1; }

# Clean up downloaded files
echo "Cleaning up..."
rm -rf "${ZIP}"
rm -rf "./${INSTALL_DIR}"

echo "Done!"
