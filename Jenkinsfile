@NonCPS
def generateTag() {
    return "build-" + new Date().format("yyyyMMdd-HHmmss")  
}

pipeline {
    environment {
        registry = "srivallivajha/survey645"
        // registryCredential = 'dockercred'
    }
    agent any

    stages{
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Srivalli-Vajjha/SWE645.git']]])
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'echo ${BUILD_TIMESTAMP}'
                    tag = generateTag()
                    docker.withRegistry('',registryCredential){
                      def customImage = docker.build("srivallivajha/survey645:"+tag)
                   }
               }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh 'echo ${BUILD_TIMESTAMP}'
                    docker.withRegistry('',registryCredential) {
                        def image = docker.build('srivallivajha/survey645:'+tag, '.')
                        docker.withRegistry('',registryCredential) {
                            image.push()
                        }
                    }
                }
            }
        }

      stage('Deploying Rancher to single node') {
         steps {
            script{
               sh 'kubectl set image deployment/surveyform container-0=srivallivajha/survey645:'+tag
            }
         }
      }

    stage('Deploying Rancher to Load Balancer') {
       steps {
          script{
             sh 'kubectl set image deployment/surveyformlb container-0=srivallivajha/survey645:'+tag
          }
       }
    }

    }
}