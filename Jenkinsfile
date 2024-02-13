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
        stage('Install Packer') {
            steps {
                script {
                    def packerVersion = '1.7.3' // specify desired version
                    sh """
                    wget https://releases.hashicorp.com/packer/${packerVersion}/packer_${packerVersion}_linux_amd64.zip
                    unzip packer_${packerVersion}_linux_amd64.zip
                    sudo mv packer /usr/local/bin
                    """
                }
            }
        }
        stage('Build Image with Packer') {
            steps {
                sh "packer build -var 'software=${params.SOFTWARE_PACKAGE}' ubuntu-image.pkr.hcl"
            }
        }
    }
}
