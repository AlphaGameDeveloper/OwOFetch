pipeline {
    agent {
        docker {
            image 'boisvert/c-build'
            args '-v /var/run/docker.sock:/var/run/docker.sock -u root -v /mnt/bigga/Releases/OwOFetch:/releases'
        }
    }
    environment {
        GIT_ABBREV_COMMIT = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
        JENKINS_NOTIFICATIONS_WEBHOOK = credentials('discord-jenkins-webhook')
        END_FILENAME = "${GIT_ABBREV_COMMIT}_owofetch-linux.tar.gz"
        WWW_LOCATION = "https://releases.alphagame.dev/OwOFetch/${env.END_FILENAME}"
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
                sh "cp owofetch_*-linux.tar.gz /releases/${env.END_FILENAME}"
                discordSend(
                    webhookURL: env.JENKINS_NOTIFCATIONS_WEBHOOK,
                    title: "OwOFetch Release"
                    description: "WWW Location: ${env.WWW_LOCATION}"
                    link: env.WWW_LOCATION
            }
        }
    }
    post {
        always {
            script {
                def buildStatus = currentBuild.currentResult ?: 'SUCCESS'
                def discordTitle = "${env.JOB_NAME} - Build #${env.BUILD_NUMBER} ${buildStatus}"
                def discordDescription = "Commit: ${env.GIT_COMMIT}\nBranch: ${env.BRANCH_NAME}\nBuild URL: ${env.BUILD_URL}"
                discordSend(
                    webhookURL: env.JENKINS_NOTIFICATIONS_WEBHOOK,
                    title: discordTitle,
                    description: discordDescription,
                    link: env.BUILD_URL,
                    result: buildStatus
                )
            }
        }
    }
}
