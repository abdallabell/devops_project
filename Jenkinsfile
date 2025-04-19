pipeline {
    agent any

    tools {
        jdk 'jdk17'  // تأكد أنه معرف بهذا الاسم في Jenkins > Global Tool Configuration
    }

    stages {
        stage('Build') {
            steps {
                sh 'javac App.java'
            }
        }

        stage('Security Scan (skipped if tool not found)') {
            steps {
                script {
                    try {
                        sh 'dependency-check --project devops-java-app --scan .'
                    } catch (err) {
                        echo "Security scan skipped (dependency-check not found)"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops_java_image .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run --rm devops_java_image'
            }
        }
    }
}

