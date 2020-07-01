def sourcePackage = ""

pipeline {
  environment {
    registry = "linkatedu/docker-deb-builder"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Packager Git') {
      steps {
        git 'https://github.com/linkatedu/docker-deb-builder.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    
    stage('Clone another repository to subdir') {
         steps {
           sh 'rm source -rf; mkdir source'
           dir ('source') {
             git branch: 'master',
               credentialsId: '230290d6-6575-4b70-82fd-01775893aae8',
               url: 'https://github.com/linkatedu/linkat-flatpak-18.04.git'
            }
        }
    }
    
    
    stage('Build Package') {
      agent any
      steps {
         sh 'sudo ./build -i linkatedu/docker-deb-builder:$BUILD_NUMBER -o packages /var/jenkins_home/workspace/docker-packager-18.04/source'       
         }
}
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}
