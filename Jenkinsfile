pipeline {
  agent any
  
  
  options {
    // Suppress [Pipeline] step annotations for cleaner logs
    timestamps()
  }

  parameters {
    string(name: 'IBMI_SERVER', defaultValue: 'Plato', description: 'IBM i server name')
    string(name: 'TARGET_BASE_PATH', defaultValue: '/QOpenSys/OMSIFS/XMP/GITSRC/DEV/XT0748', description: 'Base IFS path for uploads')
    string(name: 'COMPARE_BRANCH', defaultValue: 'origin/master', description: 'Branch to compare against for changed files')
    string(name: 'LIBRARY', defaultValue: 'V18T0083', description: 'Library to add to library list')
    string(name: 'NOTIFY_USER', defaultValue: 'WIM', description: 'User to notify on completion')
    booleanParam(name: 'VERBOSE', defaultValue: true, description: 'Enable verbose logging (show all processing details)')
  }
  
  stages {
    stage('Process changed files') {
      steps {
        script {
          // Helper for conditional logging - only show in verbose mode
          def log = { msg -> if (params.VERBOSE) echo msg }
          
          echo "════════════════════════════════════════════════════════════"
          echo "ENVIRONMENT VARIABLES:"
          echo "════════════════════════════════════════════════════════════"
          env.getEnvironment().sort().each { key, value ->
            echo "${key}: ${value}"
          }
          echo "════════════════════════════════════════════════════════════"
          
          // Get current branch name
          def currentBranch = env.GIT_BRANCH ?: env.BRANCH_NAME ?: 
            (isUnix() ? sh(script: "git rev-parse --abbrev-ref HEAD", returnStdout: true).trim() 
                      : bat(script: "@git rev-parse --abbrev-ref HEAD", returnStdout: true).trim().readLines().last())

          // Fetch the comparison branch 
          withCredentials([usernamePassword(credentialsId: 'bitbucket-eunice-credentials-admin', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
            if (isUnix()) {
              sh(script: '''
                REMOTE_URL=$(git config --get remote.origin.url)
                AUTH_URL=$(echo "$REMOTE_URL" | sed "s|https://|https://${GIT_USER}:${GIT_PASS}@|")
                git fetch "$AUTH_URL" master
              ''', returnStdout: !params.VERBOSE)
            } else {
              bat(script: '''
                @echo off
                for /f "tokens=*" %%i in ('git config --get remote.origin.url') do set REMOTE_URL=%%i
                set AUTH_URL=%REMOTE_URL:https://=https://%GIT_USER%:%GIT_PASS%@%
                git fetch "%AUTH_URL%" master
              ''', returnStdout: !params.VERBOSE)
            }
          }

          // Get changed files between comparison branch and current HEAD
          def diffOutput
          if (isUnix()) {
            diffOutput = sh(
              script: "git diff --name-only ${params.COMPARE_BRANCH}...HEAD",
              returnStdout: true
            ).trim()
          } else {
            diffOutput = bat(
              script: "@git diff --name-only ${params.COMPARE_BRANCH}...HEAD",
              returnStdout: true
            ).trim().readLines().drop(0).join('\n')
          }

          if (!diffOutput) {
            echo "No changed files compared to ${params.COMPARE_BRANCH}."
            return
          }

          // Split into a list, excluding hidden files (dot files) and root files
          def allChangedFiles = diffOutput.split('\n').findAll { it?.trim() } as List<String>
          def changedFiles = allChangedFiles.findAll { file ->
            def isRootFile = !file.contains('/')
            // Check if any path segment starts with a dot (e.g., .vscode/actions.json)
            def isInDotFolder = file.split('/').any { segment -> segment.startsWith('.') }
            !isRootFile && !isInDotFolder
          }
          def skippedCount = allChangedFiles.size() - changedFiles.size()
          if (skippedCount > 0) {
            log("Skipped ${skippedCount} file(s) (hidden or root files)")
          }

          // Always show file count, but only list files in verbose mode
          echo "Processing ${changedFiles.size()} changed file(s) on branch '${currentBranch}'"
          log("Changed files:\n${changedFiles.collect { '  - ' + it }.join('\n')}")

          // Open IBM i connection ONCE and process all files
          onIBMi(params.IBMI_SERVER) {
            // Setup environment once
            ibmiCommand "chgenv omsxmp"
            ibmiCommand "addlible ${params.LIBRARY}"
            
            // Create base directory if it doesn't exist (suppress expected errors)
            ibmiShellExec(command: "mkdir -p ${params.TARGET_BASE_PATH}", failOnError: false)
            
            // Track directories already created to avoid redundant mkdir calls
            def createdDirs = [] as Set
            
            // Process each changed file
            def successCount = 0
            def failedFiles = []
            
            changedFiles.eachWithIndex { file, index ->
              try {
                log("Processing [${index + 1}/${changedFiles.size()}]: ${file}")
                
                // Get the directory part of the file path
                def fileDir = file.contains('/') ? file.substring(0, file.lastIndexOf('/')) : ''
                def targetDir = fileDir ? "${params.TARGET_BASE_PATH}/${fileDir}" : params.TARGET_BASE_PATH
                def targetFile = "${params.TARGET_BASE_PATH}/${file}"
                
                // Create target directory structure if needed (only once per unique dir)
                if (fileDir && !createdDirs.contains(fileDir)) {
                  ibmiShellExec(command: "mkdir -p ${targetDir}", failOnError: false)
                  createdDirs.add(fileDir)
                }
                
                // Upload file preserving directory structure
                ibmiPutIFS(from: file, to: targetDir)
                
                // Build the source
                def buildResult = ibmiCommand(
                  command: "BLDIFSOMS ACTC(*PUSH) BRANCH('${currentBranch}') STMF('${targetFile}')",
                  failOnError: false
                )
                
                if (buildResult.successful) {
                  successCount++
                  log("OK: ${file}")
                } else {
                  def errorMsg = buildResult.getPrettyMessages()
                  failedFiles.add([file: file, error: errorMsg])
                  // Always show build failures - these are unexpected errors
                  echo "FAILED: ${file}\n  ${errorMsg}"
                }
              } catch (Exception e) {
                failedFiles.add([file: file, error: e.message])
                // Always show exceptions - these are unexpected errors
                echo "ERROR: ${file}\n  ${e.message}"
              }
            }
            
            // Summary - always show
            echo "════════════════════════════════════════════════════════════"
            echo "SUMMARY: ${successCount}/${changedFiles.size()} files processed successfully"
            if (failedFiles) {
              echo "FAILURES: ${failedFiles.size()} file(s)"
              failedFiles.each { f -> echo "  - ${f.file}" }
            }
            echo "════════════════════════════════════════════════════════════"
            
            // Send notification to IBM i user
            def summary = "Processed ${successCount}/${changedFiles.size()} files from branch ${currentBranch}"
            ibmiCommand "SNDMSG MSG('${summary}') TOUSR(${params.NOTIFY_USER})"
          }
        }
      }
    }
  }
  
  post {
    failure {
      script {
        // Attempt to notify on failure (connection may not be available)
        try {
          onIBMi(params.IBMI_SERVER) {
            ibmiCommand "SNDMSG MSG('Jenkins build FAILED') TOUSR(${params.NOTIFY_USER})"
          }
        } catch (Exception e) {
          // Only show connection errors - these are unexpected
          echo "Could not send failure notification: ${e.message}"
        }
      }
    }
  }
}