pipeline {
  agent any
  stages {
    stage('Process changed files') {
      steps {
        script {

          echo params.ENV
          // Make sure we have the latest master branch locally
          sh "git fetch origin ${BASE_BRANCH}"

          // Get changed files between origin/master and current HEAD
          def diffOutput = sh(
            script: "git diff --name-only origin/${BASE_BRANCH}...HEAD",
            returnStdout: true
          ).trim()

          if (!diffOutput) {
            echo "No changed files compared to origin/${BASE_BRANCH}."
            return
          }

          // Split into a list
          def changedFiles = diffOutput.split('\n') as List<String>

          echo "Changed files:\n${changedFiles.join('\n')}"

          // Run logic per file
          changedFiles.each { file ->
            echo "Processing file: ${file}"
            onIBMi('Plato') {
              ibmiCommand "SNDMSG MSG('${file}') TOUSR(WIM)"
            }
          }
        }
      }
    }

    stage('Run IBM i Command') {
      steps {
        onIBMi('Plato') {
          ibmiCommand "SNDMSG MSG('Hello from Jenkins') TOUSR(WIM)"
        }
      }
    }
  }
}