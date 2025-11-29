pipeline {
    agent any
    stages {
        stage('Run IBM i Command') {
            steps {
                onIBMi('Plato') {
                    ibmiCommand "SNDMSG MSG('Hello from Jenkins') TOUSR(WIM)"
                }
            }
        }
    }
}