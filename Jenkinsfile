pipeline {
    agent any
    stages {
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
