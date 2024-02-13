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
                packerVersion = '1.7.3'
                def packerDir = "${env.WORKSPACE}/packer"
                sh """
                mkdir -p ${packerDir}  // -p flag makes mkdir idempotent
                curl -o ${packerDir}/packer_${packerVersion}_linux_amd64.zip https://releases.hashicorp.com/packer/${packerVersion}/packer_${packerVersion}_linux_amd64.zip
                unzip -o -d ${packerDir} ${packerDir}/packer_${packerVersion}_linux_amd64.zip
                """
                env.PATH = "${packerDir}:$PATH"
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
