#!/bin/bash

export APPLI_APACHE_SERVERNAME="https://bib-preprod.cnrs.fr"
export APPLI_APACHE_SERVERADMIN="bibcnrs@inist.fr"
export APPLI_APACHE_LOGLEVEL="info ssl:warn"
export DOCKER_HOST_IP=`ip -4 addr show docker0 | grep --perl-regexp --only-matching 'inet \K[\d.]+'`

ping -c 1 -W 1 proxyout.inist.fr >/dev/null
if [ "$?" = "0" ]; then
  export http_proxy="http://proxyout.inist.fr:8080"
  export https_proxy="http://proxyout.inist.fr:8080"
fi
