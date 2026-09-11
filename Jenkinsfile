pipeline {
  agent any

  options {
    timestamps()
  }

  parameters {
    string(name: 'IBMI_SERVER', defaultValue: 'Plato', description: 'IBM i server profile name configured in Jenkins')
    string(name: 'TARGET_BASE_PATH', defaultValue: '/QOpenSys/OMSIFS/XMP/GITSRC/DEV/XT0748', description: 'Base IFS path for uploads')
    string(name: 'COMPARE_BRANCH', defaultValue: 'origin/master', description: 'Branch to compare against for changed files')
    string(name: 'LIBRARY', defaultValue: 'V18T0083', description: 'Library to add to library list')
    string(name: 'NOTIFY_USER', defaultValue: 'WIM', description: 'User to notify on completion')
    booleanParam(name: 'VERBOSE', defaultValue: true, description: 'Enable verbose logging')
  }

  stages {
    stage('Build & Deploy TD/OMS') {
      steps {
        onIBMi(params.IBMI_SERVER) {
          tdOmsPushChanges targetBasePath: params.TARGET_BASE_PATH,
                           compareBranch: params.COMPARE_BRANCH,
                           library: params.LIBRARY,
                           notifyUser: params.NOTIFY_USER,
                           verbose: params.VERBOSE

          tdOmsDeploy branch: env.BRANCH_NAME ?: env.GIT_BRANCH ?: 'XT0748',
                      command: "STROMSDEP BRANCH('\${BRANCH}')",
                      library: params.LIBRARY,
                      notifyUser: params.NOTIFY_USER
        }
      }
    }
  }
}

