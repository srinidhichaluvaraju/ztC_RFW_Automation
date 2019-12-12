#Documentation  Keyword file. Second level file intermediating between POs and Test Cases script. In future this could be
#...    a collection of related keywords required for a set of test cases.

*** Settings ***
Library  SeleniumLibrary
Library  SSHLibrary
Resource  ./CommonWeb.robot
Resource  ./PO/LoginPage.robot
Resource  ./PO/StratusBanner.robot
Resource  ./PO/PM-Page.robot
Resource  ./PO/VM-Page.robot
Resource  ./PO/RemoteExec.robot
Resource  ../Resources/PO/VCD-Page.robot

*** Variables ***


*** Keywords ***
#<========================VM Page Keywords------------------------------->
Go To Landing Page
    LoginPage.Navigate To
    LoginPage.Verify Page Loaded

Verify Login Process
    LoginPage.Log in to EverRun  ${USER}  ${PWD}

Go To "Team" Page
    TopNav.Select "Team" Page
    Team.Verify Page Loaded

Validate "Team" Page
    Team.Validate Page Contents

Start A VM
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    VM-Page.Go To VM Page
    VM-Page.Select a given VM  ${VMNAME}
    VM-Page.Start Selected VM
    VM-Page.Verify VM Is Started  ${VMNAME}

Shutdown A VM
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    VM-Page.Go To VM Page
    VM-Page.Select a given VM  ${VMNAME}
    VM-Page.Shutdown Selected VM
    VM-Page.Verify VM Is Stopped  ${VMNAME}

Power Off A VM
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    VM-Page.Go To VM Page
    VM-Page.Select a given VM  ${VMNAME}
    VM-Page.Power Off Selected VM
    VM-Page.Verify VM Is Stopped  ${VMNAME}

Mount A Device
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    VM-Page.Go To VM Page
    VM-Page.Mount Device Via USB  ${USB}
    #VM-Page.Mount Device Via Windows Share
    #VM-Page.Mount Device Via NFS
    #VM-Page.Unmount Device And Verify

Remove A VM
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    VM-Page.Go To VM Page
    VM-Page.Select a given VM  ${VMNAME}
    VM-Page.Remove Selected VM
    VM-Page.Verify VM Is Removed  ${VMNAME}

#<========================PM Page Keywords------------------------------->
Work On Selected PM
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    PM-Page.Go To PM Page
    PM-Page.Select a given PM  ${PMNAME}
    PM-Page.Hit Work On And Confirm
    PM-Page.Verify Given Node State In Maintenance  ${PMNAME}  running (in Maintenance)

Finalize A PM
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    PM-Page.Go To PM Page
    PM-Page.Select a given PM  ${PMNAME}
    PM-Page.Hit Finalize And Confirm
    PM-Page.Verify Given Node Moves To Normal  ${PMNAME}

Shutdown A PM
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    PM-Page.Go To PM Page
    PM-Page.Select a given PM  ${PMNAME}
    PM-Page.Shutdown Selected PM
    PM-Page.Verify Given Node State In Maintenance  ${PMNAME}  powered off (in Maintenance)

Reboot A PM
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    PM-Page.Go To PM Page
    PM-Page.Select a given PM  ${PMNAME}
    PM-Page.Reboot Selected PM
    PM-Page.Verify Given Node State In Maintenance  ${PMNAME}  rebooting (in Maintenance)

#<========================RemoteExec Keywords------------------------------->

Login and Execute Command on the remote host
    RemoteExec.Open Connection And Log In  ${REMOTE-HOST}  ${REMOTE-USER}  ${REMOTE-PASSWORD}
    Execute And Get Output Downloaded  ls -la  ls.output  C:\\Users\\akumar1\\
    #RemoteExec.Execute Chain Of Commands In An Interactive Session  ${CMDLine}  ${CustomPrompt}  ${TimeOut}
    #RemoteExec.Execute Command And Verify Output  ${CMDLine}  ${ExpectedOutput}
    #RemoteExec.Execute Command And Verify Return Code  ${CMDLine}

Execute Command Download Output File From the Remote Host
    RemoteExec.Open Connection And Log In  ${REMOTE-HOST}  ${REMOTE-USER}  ${REMOTE-PASSWORD}
    RemoteExec.Execute And Get Output Downloaded  ${CMDLine}  ${SourceFile}  ${Destination}

Transfer Script To Remote Host Execute And Download Output File
    RemoteExec.Open Connection And Log In  ${REMOTE-HOST}  ${REMOTE-USER}  ${REMOTE-PASSWORD}
    RemoteExec.Put File To The Remote Server  ${SourceFile}  ${TargetDir}  ${Mode}
    RemoteExec.Execute And Get Output Downloaded  ${CmdLine}  ${OutputFile}  ${Destination}

Transfer Script To Remote Host Execute And Verify Return Code
    RemoteExec.Open Connection And Log In  ${REMOTE-HOST}  ${REMOTE-USER}  ${REMOTE-PASSWORD}
    RemoteExec.Put File To The Remote Server  ${SourceFile}  ${TargetDir}  ${Mode}
    RemoteExec.Execute And Get Output Downloaded  ${CmdLine}  ${OutputFile}  ${Destination}

#<========================VCD Page Keywords------------------------------->

Remove A VCD
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    VCD-Page.Go To VCD Page
    #PM-Page.Select a given PM  ${PMNAME}