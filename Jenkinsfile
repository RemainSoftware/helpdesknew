pipeline {
  agent any

  options {
    timestamps()
  }

  parameters {
    string(name: 'IBMI_SERVER', defaultValue: 'Plato', description: 'IBM i server profile name configured in Jenkins')
    string(name: 'TARGET_BASE_PATH', defaultValue: '/QOpenSys/OMSIFS/XMP/GITSRC/DEV/XT0748', description: 'Base IFS path for uploads')
    string(name: 'COMPARE_BRANCH', defaultValue: 'origin/master', description: 'Branch to compare against for changed files')
    booleanParam(name: 'VERBOSE', defaultValue: true, description: 'Enable verbose logging')
  }

  stages {
    stage('Build & Deploy TD/OMS') {
      steps {
        onIBMi(params.IBMI_SERVER) {
          
        // Setup session environment
          ibmi.executeCommand("CHGENV OMSXMP");
 
          tdOmsPushChanges targetBasePath: params.TARGET_BASE_PATH,
                           compareBranch: params.COMPARE_BRANCH,
                           gitCredentialsId: '238cb592-6292-4e92-aa9f-2b819ed0c156', // credential ID for the compare-branch fetch fallback
                           verbose: params.VERBOSE

          tdOmsDeploy branch: env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'XT0748',
                      command: "STROMSDEP BRANCH('\${BRANCH}')"
        }
      }
    }
  }
}

