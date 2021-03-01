#!/usr/bin/env bash

sudo apt update --fix-missing -y
sudo apt install openjdk-14-jdk -y

function clone_pull {
    Dir=$(basename "$1" .git)
    if [[ -d "$Dir" ]]; then
      cd $Dir
      git pull
    else
      git clone "$1" && cd $Dir
    fi
}

clone_pull https://gitlab.com/scsi_9/adil-test.git
#git clone https://gitlab.com/scsi_9/adil-test.git && cd "$(basename "$_" .git)"

chmod +x mvnw

./mvnw clean package