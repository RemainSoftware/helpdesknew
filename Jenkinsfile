pipeline {
  agent any
  stages {
    stage('Process changed files') {
      steps {
        script {

          // Make sure we have the latest master branch locally
          sh "git fetch origin master"

          // Get changed files between origin/master and current HEAD
          def diffOutput = sh(
            script: "git diff --name-only origin/master...HEAD",
            returnStdout: true
          ).trim()

          if (!diffOutput) {
            echo "No changed files compared to origin/master."
            return
          }

          // Split into a list
          def changedFiles = diffOutput.split('\n') as List<String>

          echo "Changed files:\n${changedFiles.join('\n')}"

          // Run logic per file
          changedFiles.each { file ->
            echo "Processing file: ${file}"
            onIBMi('Plato') {
              ibmiCommand "chgenv omsxmp"
              ibmiCommand "addlible V18T0083"
              ibmiCommand "addlible V18T0083"
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