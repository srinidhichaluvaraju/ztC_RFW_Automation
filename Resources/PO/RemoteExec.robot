*** Settings ***
Library  SeleniumLibrary
Library  String
Library  SSHLibrary
#Suite Setup  Open Connection And Log In
#Suite Teardown  Close All Connections

*** Variables ***
${REMOTE-HOST} =  10.200.129.205
${REMOTE-USER} =  root
${REMOTE-PASSWORD} =  KeepRunning

*** Keywords ***
Open Connection And Log In
    [Documentation]  This keyword can be used to open a connection channel with a remote server and loging with credentials.
    [Arguments]  ${REMOTE-HOST}  ${REMOTE-USER}  ${REMOTE-PASSWORD}
    Open Connection  ${REMOTE-HOST}
    Login  ${REMOTE-USER}  ${REMOTE-PASSWORD}

Execute Command And Verify Output
    [Documentation]    This keyword can be used to run commands on the remote machine.
    ...                The keyword returns the standard output by default.
    [Arguments]  ${CMDLine}  ${ExpectedOutput}
    ${CMDOutput} =  Execute Command  ${CMDLine}
    Should Be Equal  ${CMDOutput}  ${ExpectedOutput}

Execute Command And Verify Return Code
    [Documentation]    This keyword can be used to execute a command on the remote machine and collect its return code.
    ...                Often times the return code of the command is enough to determine the execution result.
    [Arguments]  ${CMDLine}
    ${ReturnCode} =  Execute Command  ${CMDLine}  return_stdout=False  return_rc=True
    Should Be Equal  ${ReturnCode}  ${0}

Execute Chain Of Commands In An Interactive Session
    [Documentation]    Execute Command always executes the command in a new shell.  This means that changes to the environment
    ...                are not persisted between subsequent Execute Command keyword calls. Hence you might use Write and Read Until variants
    ...               if you want to operate in the same shell (in an interactive shell).
    ...               Set the prompt and timeout as in the below example -- Set Client Configuration  prompt=[node0-node0] ~ $  timeout=20 seconds
    ...               Set the chain of commands as shown here -- avcli node-info;avcli owner-info;avcli network-info
    ...               Or like cd ..;ls;hostname;uptime
    [Arguments]  ${CMDLine}  ${CustomPrompt}  ${TimeOut}
    Set Client Configuration  prompt=${CustomPrompt}  timeout=${TimeOut}
    Write  ${CMDLine}
    ${Output} =  Read Until Prompt
    Should End With  ${Output}  ${CustomPrompt}
    [Return]  ${Output}

Execute And Get Output Downloaded
    [Documentation]    Execute Command on a remote server and redirect the output (STDOUT and STDERR) to a file. Download the output file to
    ...                the local directory. For other possibilities refer to Get File keyword description under SSHLibrary.
    [Arguments]  ${CMDLine}  ${Output_File}  ${Destination}
    LOG  Attaching redirection commands to the given command line. That is what we need to do if we want to redirect command output to a file.
    ${CMDLine} =  Catenate  ${CMDLine}  > ${Output_File} 2>&1
    Log  ${CMDLine}
    ${ReturnCode} =  Execute Command And Verify Return Code  ${CMDLine}
    Log  ${ReturnCode}
    Get File  ${Output_File}  ${Destination}

Put File To The Remote Server
    [Documentation]    Put a file from Source directory to a directory on the remote server. mode can be used to set the target file permission.
    ...                Numeric values are accepted. The default value is 0744 (-rwxr--r--). If None value is provided, setting modes will be skipped.
    ...                For other possibilities refer to Put File keyword description under SSHLibrary.
    [Arguments]  ${SourceFile}  ${Destination}  ${Mode}
    LOG  Putting a file onto the remote server. (with or without file mode change.)
    Put File  ${SourceFile}  ${Destination}  ${Mode}

Get File From The Remote Server
    [Documentation]    Get a file from Source directory on the remote server  to a local destination directory.
    ...                For other possibilities refer to Get File keyword description under SSHLibrary.
    [Arguments]  ${SourceFile}  ${Destination}
    LOG  Getting a file from the remote server.
    Get File  ${SourceFile}  ${Destination}







#Close Connection

#avcli node-info;sleep 15;avcli owner-info;sleep 15;avcli network-info;sleep 15
#cd ..;ls;hostname;uptime;whoami