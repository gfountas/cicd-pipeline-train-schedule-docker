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
            app = docker.build('gfountas/trainapp')
          }
        }
        stage('Test Docker Image'){
          steps {
            echo 'Testing docker image'
            app.inside {
              sh 'echo $(curl localhost:8080)'
            }
          }
      }
    }
}
