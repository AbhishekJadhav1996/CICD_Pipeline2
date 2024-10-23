pipeline {
 agent {
        label 'windows_Node'
    }         tools {
                  maven "Maven"
                  jdk "JDK11"
         }
         stages {
                  stage('Initialize'){
                           steps{
                                    echo "PATH = ${M2_HOME}/bin:${PATH}"
                echo "M2_HOME = /opt/maven"
            }
        }
                  stage('Validate'){
                         steps{
                           echo "VALIDATE"
                           bat "mvn validate"
                         }
                  }        
               stage('Compile'){
            steps{
                echo "COMPILE"
             bat "mvn compile"
            }
        }
stage('test'){
steps{
echo "Test"
bat "mvn clean test"
}
}
stage('Sonar Analysis') {
steps {
// use the SonarQube Scanner to analyze the project
withSonarQubeEnv('SonarQube') {
     bat 'mvn sonar:sonar'
}
}
}
                  
                      stage('Package'){
            steps{
                echo "PACKAGE"
             bat "mvn package"
            }
        }
                  
                   stage('Install'){
            steps{
                echo "INSTALL   "
             bat "mvn clean install"
            }
        }
                  
stage('Upload_Artifact') {
steps {
    script{
def server = Artifactory.server 'artifactory'
               def uploadSpec = """{
 "files": [
 {
      "pattern": "target/*.jar",
"target": "CI_2_POC/"
}
]
}"""
server.upload(uploadSpec)
}
}
}
}
    
           post {
                 always {
                     jiraSendBuildInfo site: 'abhisheknewjirasite.atlassian.net', branch: 'master'
                 }
             }
        }
