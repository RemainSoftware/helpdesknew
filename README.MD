# Welcome to this repository
This repository serves as an example on how to manage sources with git and how to connect these sources to TD/OMS. 


# TD/OMS CI/CD Workflow for Git Managed Projects

THIS IS NOT THE OFFICIAL DOCUMENTATION AND MAY BE STALE. PLEASE FIND BLDIFSOMS AND GIT [ON THE OFFICIAL DOCUMENTATION PAGES.](https://remainsoftware.com/wiki)


This document describes the TD/OMS-based CI/CD workflow used for the IBM i backend source repository in this workspace. It combines:
- TD/OMS change control
- Git-based source management
- VS Code / Code for IBM i build actions
- Jenkins pipeline automation
- Build-queue handling for object deployment

---

## 1. Project overview

The repository is organized around IBM i source types and is intended to be tracked by git and deployed through TD/OMS branches and Git branches.


---

## 2. TD/OMS and Git integration model

The repository is built around a simple integration pattern:

1. Source is stored in Git.
2. A developer updates a source in the appropriate folder.
3. VS Code triggers the TD/OMS build action.
4. TD/OMS connects the source to the active task.
5. The object is compiled and queued for deployment/build processing.
6. The Jenkins pipeline can repeat the same flow for branch-based CI/CD validation.

This keeps the source of truth in Git while the object lifecycle remains controlled by TD/OMS.

---

## 3. Naming convention
Even though 'naming things' is one of the two hardest things in computer science, we  want to come up with more creative naming concepts now we are free to do so. 

This repository has chosen the following structure.

```text
root/
├── <rootfiles>
├── package/
│   └── ...src
└── ...
```

e.g.
```text
root/
├── customer/
│   └── api/
│   │   └── CustomerAPI.OMQCHGCU.pgm.rpgle
|   └── legacy5250/
│       └── src/
│           └── CustomerMaintenance.OMH011.pgm.rpgle
│           └── CustomerMaintenance.OMH011.file.dspf
└── ...
```

This is a modern IBM i source layout and can be used by the TD/OMS-Git integration. Source files are not stored as traditional source physical file members only; they are managed as stream files in an IFS layout compatible with Git and TD/OMS.

The source file naming convention is aligned with the TD/OMS registry key OMQIFSSRCNAMEC and follows the pattern:

```text
*DNT - Description, name, type (default)
```

It can handle filenames with description.
Example patterns:

```text
✅ CustomerMaintenance.omh011.pgm.rpgle (OMH011 *PGM)
✅ Customer_Maintenance.omh011.pgm.rpgle (OMH011 *PGM)
✅ Api_Maintain_Customer.omqchgcu.module.sqlrpgle (OMQCHGCU *MODULE) 
✅ SelectIncidentsForEscalation.omh026p.prtf
❌ Select_IncidentsForEscalation.omh026p.prtf (choose underscore OR case naming)
✅ CustomerMaintenance.omh011c.clle
✅ CustomerMaintenance.omh011d.dspf
✅ Customers.omcus.rpgleinc
✅ CustomerLogical.omcusl1.lf
❌ command.cmd
❌ file.pf 
❌ myfile.file.pf 
```

```text
*NDT - Name, Description, type (discouraged)
```

Discouraged because the implementation name does not have to start at the beginning. For grouping we use packages and for searching it does not matter where the implementation name is. 

Example pattern:

```text
✅ omh011.CustomerMaintenance.pgm.rpgle 
✅ omcus.Customers.pf
✅ omcusl1.Customer_Logical.lf
✅ strcm.StartCustomerMaintenance.cmd
✅ omh026p.Select_Incidents_For_Escalation.prtf
❌ omh026p.Select_IncidentsForEscalation.prtf (choose underscore OR case naming)
✅ omcusl1.CustomerLogical.lf
❌ command.cmd
❌ file.pf 
```

```text
*NT - Name, type (discouraged)
```

Discouraged because the cryptic name works for you but not for any new person joining. 

Example pattern:

```text
❌ omh011.CustomerMaintenance.pgm.rpgle 
❌ Customerstable.omcus.pf
❌ mycommand.cmd
✅ myfile.pf 
✅ PGM01.pgm.rpgle 
```

The description of the file may be added to the source using the ***%TEXT: Description is here%*** syntax in one of the first 80 lines of the source.

The IFS Extensions to Object Types table (OMTEX) can be used to define special extension to object type mapping. E.g.:
    

| Document id  | Object type  | Object Attribute |
|--------|--------------|---------------------|
| special.rpgle | *PGM | RPGLE  |
| crypto.clle | *PGM | CLLE  |

Based on some special file extension, a source can be treated different in TD/OMS. For example, it gives you a hook to label it for special postprocessing.

### Push to source files

If you still want to push to sourcefiles for compilation, the last directory name will be used as the sourcefile name. For example, the file:
    
*customers/**rpgsrc**/CustomerMaintenance.OMH001.pgm.rpgle*

will use RPGSRC as the name when requested to store it in a source file.

---

## 4. Setup and initialization

The IBM i command INZGITOMS is used when creating or porting an existing source library into the Git/IFS structure.

### Purpose of INZGITOMS

INZGITOMS is used to:
- read source from traditional IBM i source physical files
- convert it to IFS stream files
- create the Git-compatible folder structure
- align the source with TD/OMS object metadata

Typical flow:

```text
TD/OMS Application -> INZGITOMS -> IFS stream file -> Git repo -> TD/OMS task integration
```

This is generally a one-time setup activity for a repository that previously lived entirely in IBM i source files.

---

## 5. VS Code development workflow

The user workflow in VS Code is intentionally simple:

1. Open the Git repository in VS Code.
2. Connect to the IBM i using code4i
3. Assign an upload directory (e.g. /home/user/upload/tdoms
4. Edit an IFS stream file in the correct folder.
5. Press Ctrl+E.
6. Code for IBM i executes the TD/OMS build action.
7. The source is connected to the TD/OMS task and built.

### Typical actions.json configuration

The TD/OMS action used in this workspace is the push-to-task action. This command
has different flavors for different types of files. A default could be:

```json
{
  "name": "TD/OMS",
  "command": "BLDIFSOMS ACTC(*PUSH) BRANCH('&BRANCH') STMF('&RELATIVEPATH') DIR('&WORKDIR') ADDTOBQ(*YES) RLSBQ(*DIRECT) CONSTMF(*YES)",
  "deployFirst": true,
  "environment": "ile",
  "extensions": ["GLOBAL"]
}
```


## 6. Backend Processing

TD/OMS:
- reads the stream file name
- resolves the source/object metadata
- identifies the associated TD/OMS object
- connects the file to the active task
- builds or compiles the object according to task rules
- supports the CI/CD handoff from Git to TD/OMS

The command performs the following steps:

1. Reads the IFS file path and file name.
2. Parses the name using the OMQIFSSRCNAMEC convention.
3. Determines:
   - source description
   - object name
   - object type
   - source type
   - environment/branch association
4. Looks up the matching TD/OMS task or object context.
5. Associates the stream file with the task.
6. Validates and pushes the source content into the change system.
7. Triggers the compilation/build flow in the IBM i environment.


## 7. Jenkins pipeline integration

The project uses a Jenkins multibranch pipeline to automate the CI/CD process when changes are pushed to the repository. The TD/OMS Jenkins plugin is available from the jenkins plugin repository.

### Trigger types

- Webhooks from the Git server
- Polling of the repository
- Manual job execution

### Pipeline stages

The Jenkins pipeline generally follows this logic:

```text
omsChangedFiles step -> for each changed files -> omsPush step

-> omsReleaseBQ step 
-> omsDeploy step
```

After associating the source with a TD/OMS task, the artifact can be queued for compilation. Release of the build queue is either direct or batched. As a final action, the omsReleaseBQ step can be used to release the queue. 

## 9. Branch and task relationship

The project depends on a clear branch-to-task mapping.

This can either be done by associating a branch to a ticket and linking the ticket to a task, or naming the branch in such a way that the task can be derived 

---

## 10. Recommended repository conventions

For this workspace, the following conventions should remain consistent:

- Keep source files in the correct IFS folder by type.
- Keep file names in the TD/OMS pattern: description.objectname.objecttype.extension
- Use TD/OMS and Git branches consistently for task-based work.

---

## 11. Summary
Git manages the source and TD/OMS manages the object lifecycle.

The repository structure in this workspace is organized by IBM i source type, and the build flow is built around:
- branch-aware source updates
- IFS stream-file handling
- TD/OMS task association
- build queue execution in the IBM i environment
- Deployment
