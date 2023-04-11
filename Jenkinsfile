//This file with create a CI/CD pipeline for building and deploying the dcoker image to k8 cluster using Github as source control version.

pipeline{
    
    environment {
	    	registry = "srivallivajha/studentsurvey645"
        registryCredential = 'dockerhub'
	}
agent any
  stages{
    stage('Build') {
            steps {
                script {
                    sh 'rm -rf *.war'
                    sh 'jar -cvf SurveyForm.war -C src/main/webapp .'
                    docker.withRegistry('',registryCredential){
                      def customImage = docker.build("srivallivajha/studentsurvey645:latest")
                   }
               }
            }
        }
    stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('',registryCredential) {
                        def image = docker.build('srivallivajha/studentsurvey645:latest', '.')
                        docker.withRegistry('',registryCredential) {
                            image.push()
                        }
                    }
                }
            }
        }
   
    // stage('Login') {
    //   steps {
    //     sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
    //    }
    // }
    // stage("Push image to docker hub"){
    //   steps {
    //     sh 'docker push srivallivajha/studentsurvey645:latest'
    //   }
    // }
  //       stage("deploying on k8")
	// {
	// 	steps{
	// 		sh 'kubectl set image deployment/deploy1 container-0=srivallivajha/studentsurvey645:latest -n default'
	// 		sh 'kubectl rollout restart deploy deploy1 -n default'
	// 	}
	// } 
  }
 
  post {
	  always {
			sh 'docker logout'
		}
	}    
}
