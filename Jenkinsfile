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
            sh 'docker build -t gfountas/trainapp .'
            sh 'docker run -d --name trainapp -p 8090:8080 gfountas/trainapp'
            sh 'curl localhost:8090'
            sh 'docker rm -f trainapp'
          }
        }
    }
}
