pipeline {
    agent any
    stages {
      stage('Build') {
            steps {
                echo 'Running build automation'
                sh './gradlew build --no-daemon'
                archiveArtifacts artifacts: 'dist/trainSchedule.zip'
            }
        }
        stage('Build Docker Image'){
          steps {
            echo 'Building docker image'
            script {
              app = docker.build('gfountas/trainapp')
            }
          }
        }
        stage('Test Docker Image'){
          steps {
            echo 'Testing docker image'
            script {
              app.inside {
                sh 'echo $(curl localhost:8080)'
              }
            }
          }
        }
        stage('Push Docker Image to docker registry'){
          steps {
            echo 'Pushing image to docker registry'
            script {
              docker.withRegistry('https://registry.hub.docker.com','docker_hub_credentials'){
                app.push('latest')
              }
            }
          }
        }
        stage('Deploy to production'){
          steps {
            input('Deploy to production?')
            milestone(1)
            withCredentials([usernamePassword(credentialsId: 'user_username_password',usernameVariable: 'USERNAME',passwordVariable: 'USERPASS')]){
              script {
                sh "sshpass -p '$USERPASS' ssh -o StrictHostKeyChecking=no $USERNAME@gfountas3.mylabserver.com \"docker pull gfountas/trainapp:latest\""
                try {
                  sh "sshpass -p '$USERPASS' ssh -o StrictHostKeyChecking=no $USERNAME@gfountas3.mylabserver.com \"docker rm -f trainapp\""
                }
                catch(err){
                  echo "Error caught"
                }
                sh "sshpass -p '$USERPASS' ssh -o StrictHostKeyChecking=no $USERNAME@gfountas3.mylabserver.com \"docker run -d --restart=always -p 8080:8080 --name trainapp gfountas/trainapp:latest\""
              }
            }
          }
      }
    }
}
