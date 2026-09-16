pipeline {
  agent any

  options {
    timestamps()
  }

  parameters {
    string(name: 'IBMI_SERVER', defaultValue: 'Plato', description: 'IBM i server profile name configured in Jenkins')
    string(name: 'TARGET_PATH', defaultValue: '/tmp/remain/jenkins/upload', description: 'IFS path for uploads')
    string(name: 'COMPARE_BRANCH', defaultValue: 'origin/master', description: 'Branch to compare against for changed files')
    choice(name: 'LOG_LEVEL', choices: ['1', '2', '3', '4', '5'], description: 'Minimum TD/OMS log level (1=TRACE, 2=DEBUG, 3=INFO, 4=WARNING, 5=ERROR)')
  }

  stages {
    stage('Build & Deploy TD/OMS') {
      steps {
        onIBMi(params.IBMI_SERVER) {
          ibmiCommand 'CHGENV OMSXMP'
          ibmiCommand 'addlible V19T0081'

          script {
            def changedFiles = omsChangedFiles compareBranch: params.COMPARE_BRANCH,
                                                 gitCredentialsId: 'bitbucket-eunice-creds',
                                                 logLevel: params.LOG_LEVEL

            changedFiles.each { file ->
              if (file.extension.toLowerCase() in ['rpgle', 'clle', 'sqlrpgle', 'dspf']) {
                omsPush targetPath: params.TARGET_PATH,
                          relativePath: file.relativePath,
                          branch: env.BRANCH_NAME ?: env.GIT_BRANCH,
                          logLevel: params.LOG_LEVEL
              }
              else {
                omsPush targetPath: params.TARGET_PATH,
                          relativePath: file.relativePath,
                          connectStreamFile: '*YES',
                          branch: env.BRANCH_NAME ?: env.GIT_BRANCH,
                          logLevel: params.LOG_LEVEL
              }
            }
 
            ibmiCommand "BLDIFSOMS ACTC(*DEPLOY) BRANCH('${env.BRANCH_NAME}')"
          }
        }
      }
    }
  }
}

