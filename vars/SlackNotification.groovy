#!/usr/bin/env groovy

def notification (String value) {
        
        slackSend channel: 'moeez_testing', message: "Please Find status of Job status- ${currentBuild.currentResult} Build Name-${env.JOB_NAME} Build Number-${env.BUILD_NUMBER} Build URL-${env.BUILD_URL}"
}

def hello() {
        
    sh "echo hello world"
}