pipeline {
    agent { label "linux" }
    stages {
        stage ('compile/test') {
            steps {
                withMaven(globalMavenSettingsConfig: 'ae44f8b3-3bf7-4624-8e87-74659f3f817f', maven: 'maven3', mavenSettingsConfig: '', traceability: true) {
                    sh "mvn clean test"
                }
            }
        }
        stage ('build/push docker image') {
            steps {
                withMaven(globalMavenSettingsConfig: 'ae44f8b3-3bf7-4624-8e87-74659f3f817f', maven: 'maven3', mavenSettingsConfig: '', traceability: true) {
                    sh "mvn package deploy -Dmaven.resources.skip=true -Dmaven.compile.skip=true -Dmaven.testResources.skip=true -Dmaven.testCompile.skip=true -Dmaven.test.skip=true"
                }
                withDockerRegistry(credentialsId: 'ff14fbff-2a2b-4999-9979-1e31dbdf2786', url: 'http://10.10.60.59:1111') {
                    sh "docker tag myregsistry:8081/myproject/tomcat 10.10.60.63:1111/myproject/tomcat"
                    sh "docker push 10.10.60.59:1111/myproject/tomcat"
                }
            }
        }
    }
    post {
        success {
            cleanWs cleanWhenAborted: false, cleanWhenFailure: false, cleanWhenNotBuilt: false, cleanWhenUnstable: false
        }
    }
}
