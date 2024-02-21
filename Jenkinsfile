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
                   
                    def packerVersion = '1.7.3'
                    def packerDir = "${env.WORKSPACE}/packer_installation"
                    sh """
                    mkdir -p ${packerDir}
                    curl -o ${packerDir}/packer_${packerVersion}_darwin_amd64.zip https://releases.hashicorp.com/packer/${packerVersion}/packer_${packerVersion}_darwin_amd64.zip
                    unzip -o -d ${packerDir} ${packerDir}/packer_${packerVersion}_darwin_amd64.zip
                    chmod +x ${packerDir}/packer
                    """
            
                }
            }
        }

        stage('Build Image with Packer') {
            steps {
                    withCredentials([file(credentialsId: 'gcp_serviceaccount', variable: 'GOOGLE_APPLICATION_CREDENTIALS')]) 
                    {
                        sh """
                        ${env.WORKSPACE}/packer_installation/packer init ."
                        ${env.WORKSPACE}/packer_installation/packer build \\
                        -var 'software=${params.SOFTWARE_PACKAGE}' \\
                        -var 'account_file=${GOOGLE_APPLICATION_CREDENTIALS}' \\
                        'ubuntu-image.pkr.hcl"
                        """
                    }
                }
        }  

       

   }

}