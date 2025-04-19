
pipeline {
    agent any

    environment {
        // تحديد اسم التطبيق والصورة الخاصة بـ Docker
        APP_NAME = 'devops-java-app'
        DOCKER_IMAGE = 'devops_java_image'
    }

    stages {
        // المرحلة الأولى: فحص الكود
        stage('Checkout Code') {
            steps {
                // سحب الكود من مستودع GitHub
                git branch: 'main', url: 'https://github.com/abdallabell/devops_project.git'
            }
        }

        // المرحلة الثانية: بناء الكود (Build)
        stage('Build Java Application') {
            steps {
                // بناء تطبيق جافا باستخدام الأمر javac
                sh 'javac App.java'
            }
        }

    

        stage('Security Check') {
            steps {
                // فحص الأمان باستخدام OWASP Dependency-Check
                sh 'dependency-check --project devops-java-app --scan .'
            }
        }

        


        // المرحلة الرابعة: إعداد Docker
        stage('Build Docker Image') {
            steps {
                // بناء صورة Docker
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        // المرحلة الخامسة: تشغيل Docker
        stage('Run Docker Container') {
            steps {
                // تشغيل الحاوية بعد بناء الصورة
                sh 'docker run -d --name $APP_NAME $DOCKER_IMAGE'
            }
        }

        // المرحلة السادسة: اختبار التطبيق داخل الحاوية
        stage('Test Application') {
            steps {
                // اختبار التطبيق داخل الحاوية (على سبيل المثال اختبار بسيط عبر curl)
                sh 'docker exec $APP_NAME curl http://localhost:8080/health'
            }
        }

        // المرحلة السابعة: نشر التطبيق (Deployment)
        stage('Deploy Application') {
            steps {
                // نشر التطبيق داخل الحاوية
                sh 'docker run -d --name $APP_NAME -p 8080:8080 $DOCKER_IMAGE'
            }
        }

        // المرحلة الثامنة: التحقق من حالة التطبيق بعد النشر
        stage('Verify Application') {
            steps {
                // فحص الحالة بعد النشر باستخدام curl
                sh 'curl http://localhost:8080/health'
            }
        }

        // المرحلة التاسعة: تنظيف الحاويات القديمة
        stage('Cleanup Docker Containers') {
            steps {
                // تنظيف الحاويات القديمة التي تعمل
                sh 'docker ps -q --filter "status=exited" | xargs docker rm'
            }
        }
    }

    post {
        success {
            // إذا كان التنفيذ ناجحًا، أرسل بريدًا إلكترونيًا أو رسالة إشعار
            echo 'The pipeline has successfully completed.'
        }
        failure {
            // إذا فشل التنفيذ، أرسل رسالة خطأ أو إشعار
            echo 'The pipeline has failed.'
        }
    }
