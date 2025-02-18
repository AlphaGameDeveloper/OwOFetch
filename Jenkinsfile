pipeline {
    agent {
        image 'boisvert/c-build'
        args '-v /var/run/docker.sock:/var/run/docker.sock -u root -v /mnt/bigga/Releases/OwOFetch:/releases'
    }
    environment {
        GIT_ABBREV_COMMIT = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'make release'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh './owofetch_*-linux/owofetch'
            }
        }
        stage('Release') {
            steps {
                sh 'cp owofetch_*-linux.tar.gz /releases/$GIT_ABBREV_COMMIT_owofetch-linux.tar.gz'
            }
        }
    }
}