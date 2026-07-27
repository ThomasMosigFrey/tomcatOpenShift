pipeline {
    agent { label "linux" }
    stages {
        stage ('compile/test') {
            steps {
                withMaven(globalMavenSettingsConfig: 'globalMavenSettingsConfig', mavanLocalRepo: '.repository', 'maven3', traceability: true) {
                    sh "mvn clean test"
                }
            }
        }
        stage ('build docker image') {
            steps {
                    sh "docker build ."
            }
        }
    }
    post {
        success {
            cleanWs cleanWhenAborted: false, cleanWhenFailure: false, cleanWhenNotBuilt: false, cleanWhenUnstable: false
        }
    }
}
