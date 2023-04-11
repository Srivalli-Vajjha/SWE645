//This file with create a CI/CD pipeline for building and deploying the dcoker image to k8 cluster using Github as source control version.

pipeline{
    agent any
    environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	}
  stages{
    stage('Build') {
      steps {
	      script{
	sh 'rm -rf *.war'
        sh 'jar -cvf SurveyForm.war -C src/main/webapp .'  
	       docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS){
                  def customImage = docker.build("srivallivajha/studentsurvey645:latest")
               }
      }	
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
       }
    }
    stage("Push image to docker hub"){
      steps {
        sh 'docker push srivallivajha/studentsurvey645:latest'
      }
    }
        stage("deploying on k8")
	{
		steps{
			sh 'kubectl set image deployment/deploy1 container-0=srivallivajha/studentsurvey645:latest -n default'
			sh 'kubectl rollout restart deploy deploy1 -n default'
		}
	} 
  }
 
  post {
	  always {
			sh 'docker logout'
		}
	}    
}
