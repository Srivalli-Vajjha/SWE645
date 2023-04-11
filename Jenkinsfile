//This file with create a CI/CD pipeline for building and deploying the dcoker image to k8 cluster using Github as source control version.

pipeline{
    
    environment {
	    	registry = "srivallivajha/studentsurvey645"
        registryCredential = 'dockerhub'
	}
agent any
  stages{
    stage('Building war') {
            steps {
                script {
                    sh 'rm -rf *.war'
                    sh 'jar -cvf SurveyForm.war -C src/main/webapp .'
                    def dateTag = new Date().format("yyyyMMdd-HHmmss")
               }
            }
        }
    stage('Pushing latest code to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('',registryCredential) {
                        def image = docker.build('srivallivajha/studentsurvey645:'+ dateTag, '.')
                        docker.withRegistry('',registryCredential) {
                            image.push()
                        }
                    }
                }
            }
        }
     stage('Deploying to single node in Rancher') {
         steps {
            script{
               sh 'kubectl set image deployment/deploy1 container-0=srivallivajha/studentsurvey645:'+dateTag
               sh 'kubectl set image deployment/deploylb conatiner-0=srivallivajha/studentsurvey645:'+dateTag
            }
         }
      }
  }
 
  post {
	  always {
			sh 'docker logout'
		}
	}    
}
