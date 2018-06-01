#!/usr/bin/env groovy

pipeline {
  agent any

  options {
    ansiColor('xterm')
    timestamps()
  }

  libraries {
    lib("pay-jenkins-library@master")
  }

  stages {
    stage('Docker Build') {
      steps {
        script {
          buildAppWithMetrics{
            app = "tcp-proxy"
          }
        }
      }
      post {
        failure {
          postMetric("tcp-proxy.docker-build.failure", 1)
        }
      }
    }

    stage('Docker Tag') {
      steps {
        script {
          dockerTagWithMetrics {
            app = "tcp-proxy"
          }
        }
      }
      post {
        failure {
          postMetric("tcp-proxy.docker-tag.failure", 1)
        }
      }
    }
    stage('Deploy') {
      when {
        branch 'master'
      }
      steps {
        deployEcs("tcp-proxy")
      }
    }
    stage('Complete') {
      failFast true
      parallel {
        stage('Tag Build') {
          when {
            branch 'master'
          }
          steps {
            tagDeployment("tcp-proxy")
          }
        }
        stage('Trigger Deploy Notification') {
          when {
            branch 'master'
          }
          steps {
            triggerGraphiteDeployEvent("tcp-proxy")
          }
        }
      }
    }
  }
  post {
    failure {
      postMetric(appendBranchSuffix("tcp-proxy") + ".failure", 1)
    }
    success {
      postSuccessfulMetrics(appendBranchSuffix("tcp-proxy"))
    }
  }
}
