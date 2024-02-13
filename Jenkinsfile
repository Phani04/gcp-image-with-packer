pipeline {
    agent any
    parameters {
        choice(name: 'SOFTWARE_PACKAGE', choices: ['nginx', 'tomcat'], description: 'Select the software package to install.')
    }
    stages {
        stage('Checkout') {
            steps {
                git(branch: 'main', url: 'https://github.com/Phani04/gcp-image-with-packer.git')
            }
        }
        stage('Build Image with Packer') {
            steps {
                sh "packer build -var 'software=${params.SOFTWARE_PACKAGE}' ubuntu-image.pkr.hcl"
            }
        }
    }
}
