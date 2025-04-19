pipeline {
    agent any

    tools {
        // تحديد الأدوات المستخدمة في Jenkins مثل JDK و Maven
        jdk 'jdk17' // تأكد من أنك قد قمت بتحديد JDK 17 في Jenkins
        maven 'maven3' // تحديد Maven إذا كنت تستخدمه للبناء (اختياري)
    }

    stages {
        stage('Checkout') {
            steps {
                // سحب الكود من الريبو
                git 'https://github.com/abdallabell/Ab_01.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    // بناء تطبيق جافا باستخدام Maven أو Gradle أو أي أداة بناء أخرى
                    sh 'mvn clean install'  // إذا كنت تستخدم Maven
                    // sh './gradlew build'  // إذا كنت تستخدم Gradle
                }
            }
        }

        stage('Security Check') {
            steps {
                // فحص الأمان باستخدام OWASP Dependency-Check
                sh 'dependency-check --project devops-java-app --scan .'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // بناء صورة Docker من Dockerfile
                    sh 'docker build -t devops-java-app .'
                }
            }
        }

        stage('Run Docker') {
            steps {
                script {
                    // تشغيل الحاوية من الصورة التي تم إنشاؤها
                    sh 'docker run -d -p 8080:8080 devops-java-app'
                }
            }
        }
    }

    post {
        always {
            // يمكنك هنا إضافة أي إجراءات يجب تنفيذها بعد كل عملية (مثل إرسال إشعار بالبريد الإلكتروني، تنظيف الحاويات القديمة، إلخ).
            cleanWs()  // تنظيف المساحة بعد تنفيذ البايبلاين
        }
    }
}

