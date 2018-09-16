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
            dockerfile {
              filename 'Dockerfile'
              dir '.'
              label 'gfountas/trainapp'
            }
          }
        }
    }
}
