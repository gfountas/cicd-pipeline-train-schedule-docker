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
              }
            }
          }
      }
    }
}
