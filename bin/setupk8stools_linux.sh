#!/bin/bash
if [ "${DEBUG}" ]; then
        set -x
fi
if [ ! -d "${HOME}" ]; then
        echo "Error, home directory ${HOME} not found or not set"
fi

get_github_latest_release() {
  #curl --silent "https://api.github.com/repos/$1/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
  #reduce requirements, use grep only, without sed
  curl --silent "https://api.github.com/repos/$1/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")'
}
BINDIR="${HOME}/bin"
if [[ -d "${HOME}/opt/bin" ]]; 
then
  BINDIR="${HOME}/opt/bin"
else
  if [[ ! -d "${BINDIR}" ]]; then
    echo "no bin path found at ${BINDIR} or ${HOME}"; exit
  fi
fi
echo "##
This script will setup kubernetes tools in your ${BINDIR}/<toolname> folders and symlink them to ${BINDIR} to simplify setting up your local cli tools
Ensure your ${BINDIR} folder is on your path so the downloaded tools are executable
"

read -p "Proceed with setup? (Y/n) " -n 1 -r
echo
[[ ! $REPLY =~ ^[Yy]$ ]] &&  exit

## Kubectl
KUBECTL_VERSION="$(curl -L -s https://dl.k8s.io/release/stable.txt)"
KUBECTL_PATH="${HOME}/opt/kubectl/${KUBECTL_VERSION}"

read -p "Install kubectl ${KUBECTL_VERSION}? (Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ ! -x "${KUBECTL_PATH}/kubectl" ]; then
    echo "Downloading kubectl v.${KUBECTL_VERSION}"
    mkdir -p "${KUBECTL_PATH}"

    curl -L "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -o "${KUBECTL_PATH}/kubectl"
    chmod +x "${KUBECTL_PATH}/kubectl"
    ln -sf "${KUBECTL_PATH}/kubectl" "/${BINDIR}/kubectl"
    ls -l "${BINDIR}/kubectl"
  else
    echo "kubectl ${KUBECTL_VERSION} already exists: ${KUBECTL_PATH}/kubectl"
  fi
else
  echo "Skipping:"
fi

## kubectx/kubens

KUBECTX_VERSION="$(get_github_latest_release "ahmetb/kubectx")"
KUBECTX_PATH="${HOME}/opt/kubectx/${KUBECTX_VERSION}"

read -p "Install kubectx/kubens ${KUBECTX_VERSION}? (Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ ! -x "${KUBECTX_PATH}/kubectx" ]; then
    echo "Downloading kubectx ${KUBECTX_VERSION}"
    mkdir -p "${KUBECTX_PATH}"
    curl -L "https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubectx_${KUBECTX_VERSION}_linux_x86_64.tar.gz" -o "${KUBECTX_PATH}/kubectx.tar.gz"
    tar zxf "${KUBECTX_PATH}/kubectx.tar.gz" -C "${KUBECTX_PATH}/"
    curl -L "https://github.com/ahmetb/kubectx/releases/download/${KUBECTX_VERSION}/kubens_${KUBECTX_VERSION}_linux_arm64.tar.gz" -o "${KUBECTX_PATH}/kubens.tar.gz"
    tar zxf "${KUBECTX_PATH}/kubens.tar.gz" -C "${KUBECTX_PATH}/"
    chmod +x "${KUBECTX_PATH}/kubens" "${KUBECTX_PATH}/kubectx"
    ln -sf "${KUBECTX_PATH}/kubens" "${BINDIR}/kubens"
    ln -sf "${KUBECTX_PATH}/kubectx" "${BINDIR}/kubectx"
    ls -l "${BINDIR}/kubectx"
    ls -l "${BINDIR}/kubens"
  else
    echo "kubectx ${KUBECTX_VERSION} already exists: ${KUBECTX_PATH}/kubectx|kubens"
  fi
else
  echo "Skipping:"
fi

## helm
HELM_VERSION="$(get_github_latest_release "helm/helm")"
HELM_PATH="${HOME}/opt/helm/${HELM_VERSION}"

read -p "Install Helm ${HELM_VERSION}? (Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ ! -x "${HELM_PATH}/helm" ]; then
    echo "Downloading helm ${HELM_VERSION}"
    mkdir -p "${HELM_PATH}/helm"
    curl -L "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" -o "${HELM_PATH}/helm.tar.gz"
    tar zxf "${HELM_PATH}/helm.tar.gz" -C "${HELM_PATH}/"
    chmod +x "${HELM_PATH}/helm" "${HELM_PATH}/helm"
    ln -sf "${HELM_PATH}/helm" "${BINDIR}/helm"
    ls -l "${BINDIR}/helm"
  else
    echo "Helm ${HELM_VERSION} already exists: ${HELM_PATH}/helm"
  fi
else
  echo "Skipping:"
fi

## stern
STERN_VERSION="$(get_github_latest_release "wercker/stern")"
STERN_PATH="${HOME}/opt/stern/${STERN_VERSION}"

read -p "Install Stern ${STERN_VERSION}? (Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ ! -x "${STERN_PATH}/stern" ]; then
    echo "Downloading stern version: ${STERN_VERSION}"
    mkdir -p "${STERN_PATH}"
    curl -L "https://github.com/wercker/stern/releases/download/${STERN_VERSION}/stern_linux_amd64" -o "${STERN_PATH}/stern"
    chmod +x "${STERN_PATH}/stern"
    ln -sf "${STERN_PATH}/stern" "${BINDIR}/stern"
    ls -l "${BINDIR}/stern"
  else 
    echo "stern ${STERN_VERSION} already exists: ${STERN_PATH}/stern"
  fi
else
  echo "Skipping"
fi


## flux
# TODO
FLUX_VERSION="$(get_github_latest_release "fluxcd/flux2")"
FLUX_PATH="${HOME}/opt/flux/${FLUX_VERSION}"

read -p "Install flux ${FLUX_VERSION}? (Y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ ! -x "${FLUX_PATH}/flux" ]; then
    echo "Downloading flux ${FLUX_VERSION}"
    mkdir -p "${FLUX_PATH}"
    curl -L "https://github.com/fluxcd/flux2/releases/download/v${FLUX_VERSION}/flux_${FLUX_VERSION}_linux_amd64.tar.gz" -o "${FLUX_PATH}/flux"
    chmod +x "${FLUX_PATH}/flux"
    ln -sf "${FLUX_PATH}/flux" "${BINDIR}/flux"
    ls -l "${BINDIR}/flux"
  else
    echo "flux ${FLUX_VERSION} already exists : ${FLUX_PATH}"
  fi
else
  echo "Skipping:"
fi
echo
echo "Done"
echo