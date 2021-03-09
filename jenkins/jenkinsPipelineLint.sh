#!/usr/bin/env bash
#
# Linting via HTTP POST using curl
# https://jenkins.io/doc/book/pipeline/development/
#
# Parameters: $1 - path to Jenkinsfile
#
# Assuming "anonymous read access" has been enabled on your Jenkins instance.
# JENKINS_URL=[root URL of Jenkins master]
# JENKINS_CRUMB is needed if your Jenkins master has CRSF protection enabled as it should
JENKINS_URL=http://jenkinsqa.devel6.lmc:8087
JENKINS_CRUMB=`curl "$JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)"`
curl -X POST -H $JENKINS_CRUMB -F "jenkinsfile=<$1" $JENKINS_URL/pipeline-model-converter/validate
