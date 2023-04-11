pipeline {
   environment {
        registry = "srivallivajha/survey645:"
        registryCredential = 'dockercred'
        TIMESTAMP = new Date().format("yyyyMMdd_HHmmss")
    }
   agent any

   stages {
      stage('Build') {
         steps {
            script{
               sh 'rm -rf *.war'
               sh 'echo ${BUILD_TIMESTAMP}'
               //sh 'echo ${BUILD_TIMESTAMP}'
		   tag = generateTag()
               docker.withRegistry('https://index.docker.io/v1/', registryCredential){
                  def customImage = docker.build("srivallivajha/survey645:${env.TIMESTAMP}")
               }
            }
         }
      }

      stage('Push Image to Dockerhub') {
         steps {
            script{
               docker.withRegistry('https://index.docker.io/v1/', registryCredential){
                  sh "docker push srivallivajha/survey645:${env.TIMESTAMP}"
               }
            }
         }
      }

      stage('Deploying Rancher to single pod') {
         steps {
            script{
               sh "kubectl set image deployment/surveyform container-0=srivallivajha/survey645:${env.TIMESTAMP}"
            }
         }
      }
      
      stage('Deploying to Rancher using Load Balancer as a service') {
         steps {
            script{
               sh "kubectl set image deployment/surveyformlb container-0=srivallivajha/survey645:${env.TIMESTAMP}"
            }
         }
      }

      
   }
}