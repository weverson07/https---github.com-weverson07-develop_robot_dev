
pipeline {
    agent any

    stages {
        stage('Preparar Ambiente') {
            steps {
                sh 'python -m venv venv'
                sh '. venv/bin/activate && pip install -r requirements.txt'
            }
        }
        stage('Executar Testes') {
            steps {
                sh './run_tests.sh'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**/*', fingerprint: true
            junit 'results/output.xml'
        }
    }
}
