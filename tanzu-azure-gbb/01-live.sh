#!/bin/bash

########################
# include the magic
########################
. demo-magic.sh

########################
# Configure the options
########################

#
# speed at which to simulate typing. bigger num = faster
#
TYPE_SPEED=8

#
# custom prompt
#
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
#
#DEMO_PROMPT="${GREEN}➜ ${CYAN}\W "

# hide the evidence
clear


#TBS
pe "kubectl config use-context tanzu-build-service"

pe "kp image list"

#CREATE IMAGES NOW - DURING EXECUTION EXPLAIN COMMAND PARAMS, LIST ALL TARGET CLUSTERS, CHECK STATUS or CHECK BUILD LOGS
pe "kp image create spring-music --tag tanzuregistry.azurecr.io/spring-music --git https://github.com/cloudfoundry-samples/spring-music.git"
pe "kp image create aspnet-core --tag tanzuregistry.azurecr.io/aspnet-core --git https://github.com/nycpivot/dotnet-docker.git"

pe "kubectl config get-contexts --output name"

#CHECK STATUS OF IMAGES
pe "kp image status spring-music"
pe "kp build logs spring-music"

pe "kp image status aspnet-core"
#kp build logs aspnet-core


#


#TMC PORTAL - ATTACH TKG CLUSTER
