*** Settings ***
Library  SeleniumLibrary
Resource  Suite_Variables.robot
Resource  ../Resources/EverRunApp.robot
Resource  ../Resources/CommonWeb.robot
Resource  ../Resources/PO/VM-Page.robot
Resource  ../Resources/PO/PM-Page.robot
Resource  ../Resources/PO/VCD-Page.robot
Resource  ../Resources/PO/RemoteExec.robot
Resource  ../Resources/PO/StratusBanner.robot
Library  ../Libraries/Perform_TLO.py

Test Setup  Begin Web Test
Test Teardown  End Web Test
#====================================================================================================
#Robot Framework User Guide:
# https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html

# Automatic Variables :
# A number of automatic variables are available that you can make use of:
# https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#automatic-variables

#  How to execute RFW test cases?
#robot -d results tests/EverRun-Stage.robot
#robot -d results -i DevTest1 tests/EverRun-Stage.robot
#robot --reporttitle "Babybird Test Report"  --logtitle  "Babybird Test Log"
#robot --critical 100iS -c 100iD   #--critical=-c
#robot --noncritical 110iS -n 100iS
#robot --timestampouts  110iD -t 100iS
#robot -d results --randomize tests [suites,all,none]  tests/EverRun-Stage.robot
#robot -d results --loglevel [ or -L ] debug tests/EverRun-Stage.robot  OR  Set Log Level  Debug (in the script)
#
#====================================================================================================

*** Variables ***

${BROWSER} =  gc
${URL} =  https://10.71.122.12
${USER} =  admin
${PWD} =  admin_Test
${GLOBAL1}  I am a global variable
${VMNAME} =  W2K12R2
${USB} =  hp v215b - Partition1(14.9 GB)
${PMNAME} =  node0
${PrimaryPM} =  10.200.129.205
${CMDLine} =  avcli node-info
${CustomPrompt} =  [node0-node0] ~ $
${TimeOut} =  20 seconds
${ExpectedOutput} =  Hello Universe!
${SourceFile} =  node-info.output
#Current directory
${Destination} =  .


*** Test Cases ***
# Test Case Naming Conventions:
# Forcing script execution order:
# Script files normally execute in alphabetic order. You can change it by prefixing xx__ to their names.
# 01__Feature6.robot, 02__Feature3.robot,  03__Feature11.robot
# Same rule holds good for directory names.
# Use Refactor==> Rename feature for renaming files and directories.

Declare and set variables
    ${Test_Purpose} =  Set Variable  To show different types of variables.
    Set Test Variable  ${Some_data}  This is available only within this test.
    Comment  The above two variables are available only within this test.

    #Available in all tests in the current test suite.
    Set Suite Variable  ${Some_suite_data}  This is available within all tests in this suite.

    #Available in all tests in all suites
    Set Global Variable  ${Some_global_data}  This is available everywhere

Logging stuff
    [Tags]  Built-in
    Log  You are going to miss 100% of all shots you didn't try!
    Log  Never Never Never Giveup.
    Log many  Vedi  Veni  Veci
    Log to console  This can be only seen in the console, not the log!
    Log variables  This should log all the variables in the scope.
    #Suite *** variables ***
    Log  ${Some_suite_data}
    #Global *** variables ***
    Log  ${Some_global_data}
    Log  ${GLOBAL1}

#Should be able to access "Login" Page
#    [Documentation]  Testing access to "Login" Page
#    [Tags]  Login Tests
#    EverRunApp.Go To Landing Page

Should be able to login to App
    [Documentation]  Testing ability to "Login" to EverRun App
    #[Tags]  Login Tests
    [Tags]  DevTest
    Verify Login Process

Should be able to select a VM
    [Documentation]  Testing ability to "Select a VM" on the EverRun App
    [Tags]  DevTest
    Go To VM Page
    Select a given VM  ${VMNAME}

Should be able to start a VM
    [Documentation]  Verify ability to start a selected VM on EverRun App
    [Tags]  DevTest1
    Start A VM

Should be able to shutdown a VM
    [Documentation]  Verify ability to shutdown a selected VM on EverRun App
    [Tags]  DevTest2
    Shutdown A VM

Should be able to power off a VM
    [Documentation]  Verify ability to power off a selected VM on EverRun App
    [Tags]  DevTest3
    Power Off A VM

Should be able to mount device
    [Documentation]  Verify ability to mount a device on EverRun App
    [Tags]  DevTest4
    Mount A Device

Should be able to remove a VM
    [Documentation]  Verify ability to remove a VM on EverRun App
    [Tags]  DevTest5
    Remove A VM
#====================================PM Page test cases=======================================================================
Should be able to Work On a PM
    [Documentation]  Verify ability to work on a PM on EverRun App (bring it down for maintenance)
    [Tags]  DevTest6
    Work On Selected PM

Should be able to Finalize a PM
    [Documentation]  Verify ability to Finalize a PM running in maintenance on EverRun App and bring it back to normal status.
    [Tags]  DevTest7
    Finalize A PM

Should be able to Shutdown a PM
    [Documentation]  Verify ability to Shutdown a PM running in maintenance on EverRun App.
    [Tags]  DevTest8
    Shutdown A PM

Should be able to Reboot a PM
    [Documentation]  Verify ability to Reboot a PM running in maintenance on EverRun App.
    [Tags]  DevTest9
    Reboot A PM

Should be able to run a command on the remote host
    [Documentation]  Verify ability to login and run a command line on the remote host.
    [Tags]  DevTest10
    Login and Execute Command on the remote host

eE-1915
    #Should be able to run a command and download output file from the remote host
    [Documentation]  Verify ability to login and run a command line on the remote host, redirect its output to a file and download the output file.
    [Tags]  DevTest11
    Execute Command Download Output File From the Remote Host
    LOG  ${TEST_NAME}

Should be able to execute a shell script on remote server
    [Documentation]  Verify ability to login and transfer a shell script, execute on remote host, redirect its output to a file and download the output file.
    [Tags]  DevTest12
    Transfer Script To Remote Host Execute And Download Output File

Should be able to remove a VCD
    [Documentation]  Verify ability to login and remove a given VCD on the VCD Page.
    [Tags]  DevTest13
    Remove A VCD

eE-848
    [Documentation]  Test Case eE-848 :: Version : 1 :: Reset VM MTBF from the GUI - AX failure
    ...             Verify that an AX failure can be cleared by clicking the "Clear MTBF" button in the GUI
    #[Tags]  zTC100iSingle, zTC110iSingle, zTC100iDual, zTC110iDual,  everRun
    [Tags]  DT1
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    VM-Page.Select VM Verify State Is Running  ${T848_VMNAME}
    RemoteExec.Open Connection And Log In  ${REMOTE-HOST}  ${REMOTE-USER}  ${REMOTE-PASSWORD}
    RemoteExec.Put File To The Remote Server  ${T848_SourceFile}  ${T848_TargetDir}  ${T848_Mode}
    RemoteExec.Execute Command And Verify Return Code  ${T848_CmdLine}
    Builtin.Wait Until Keyword Succeeds  12 min  1 min  Element Should Be Enabled  ${ClearMTBFButton}
    StratusBanner.Verify Masthead Unit State Is Critical  ${MsgMastheadSeriousAlert}
    VM-Page.Clear MTBF For VM
    Sleep  5 minutes  reason=Allow some time for the VM to return to running state
    CommonWeb.Reload Application Page
    VM-Page.Verify VM Is Started  ${T848_VMNAME}
    Set Test Variable  ${Remote_OutputFile}  ${T848_OutputFile}
    Set Test Variable  ${Local_Destination_Dir}  ${T848_Destination}

eE-849
    [Documentation]  Test Case eE-849 :: Version : 1 :: Reset VM MTBF from the CLI - AX failure
    ...             Verify that AX failures can be cleared by using the avcli localvm-clear-mtbf command.
    #[Tags]  zTC100iSingle, zTC110iSingle, zTC100iDual, zTC110iDual,  everRun
    [Tags]  DT2
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    VM-Page.Go To VM Page
    VM-Page.Verify VM Is Started  ${T849_VMNAME-1}
    VM-Page.Verify VM Is Started  ${T849_VMNAME-2}
    CommonWeb.Reload Application Page
    VM-Page.Select VM Verify State Is Running  ${T849_VMNAME-2}
    RemoteExec.Open Connection And Log In  ${REMOTE-HOST}  ${REMOTE-USER}  ${REMOTE-PASSWORD}
    RemoteExec.Put File To The Remote Server  ${T849_SourceFile}  ${T849_TargetDir}  ${T849_Mode}
    RemoteExec.Execute Command And Verify Return Code  ${T849_CmdLine-1}
    Builtin.Wait Until Keyword Succeeds  12 min  1 min  Element Should Be Enabled  ${ClearMTBFButton}
    StratusBanner.Verify Masthead Unit State Is Critical
    VM-Page.Select VM Verify State Is Running  ${T849_VMNAME-1}
    Builtin.Wait Until Keyword Succeeds  12 min  1 min  Element Should Be Enabled  ${ClearMTBFButton}
    StratusBanner.Verify Masthead Unit State Is Critical  ${MsgMastheadSeriousAlert}
    RemoteExec.Execute Command And Verify Return Code  ${T849_CmdLine-2}
    #Don't click!  Clear MTBF For both VMs will be performed by the script using avcli command.
    Sleep  5 minutes  reason=Allow some time for the VM to return to running state
    VM-Page.Select VM Verify Button Is Disabled  ${T849_VMNAME-1}  ${ClearMTBFButton}
    VM-Page.Verify VM Is Started  ${T849_VMNAME-1}
    CommonWeb.Reload Application Page
    VM-Page.Select VM Verify Button Is Disabled  ${T849_VMNAME-2}  ${ClearMTBFButton}
    VM-Page.Verify VM Is Started  ${T849_VMNAME-2}
    Set Test Variable  ${Remote_OutputFile}  ${T849_OutputFile}
    Set Test Variable  ${Local_Destination_Dir}  ${T849_Destination}

eE-1091
    [Documentation]  Test Case eE-1091 :: Version : 2 :: Reset Device from the GUI - Windows Guest Crashes
    ...             Verify that too many Guest Crashes that stop a VM from booting, can be cleared by clicking the "Reset Device" button in the GUI.
    #[Tags]  zTC100iSingle, zTC110iSingle, zTC100iDual, zTC110iDual,  everRun
    [Tags]  DT3
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    #VM-Page.Go To VM Page
    #VM-Page.SVVSIR  ${T1091_VMNAME}
    VM-Page.Select VM Verify State Is Running  ${T1091_VMNAME}
    #CommonWeb.Reload Application Page
    VM-Page.Select VM Verify Button Is Disabled  ${T1091_VMNAME}  ${ResetDeviceButton}
    RemoteExec.Open Connection And Log In  ${REMOTE-HOST}  ${REMOTE-USER}  ${REMOTE-PASSWORD}
    RemoteExec.Put File To The Remote Server  ${T1091_SourceFile}  ${T1091_TargetDir}  ${T1091_Mode}
    RemoteExec.Execute Command And Verify Return Code  ${T1091_CmdLine}
    Builtin.Wait Until Keyword Succeeds  12 min  1 min  Element Should Be Enabled  ${ResetDeviceButton}
    VM-Page.Select VM Verify Button Is Enabled  ${T1091_VMNAME}  ${ResetDeviceButton}
    VM-Page.Hit Reset Device and Confirm
    Sleep  5 minutes  reason=Allow some time for the VM to return to running state
    VM-Page.Select VM Verify Button Is Disabled  ${T1091_VMNAME}  ${ResetDeviceButton}
    VM-Page.Verify VM Is Started  ${T1091_VMNAME}
    Set Test Variable  ${Remote_OutputFile}  ${T1091_OutputFile}
    Set Test Variable  ${Local_Destination_Dir}  ${T1091_Destination}


eE-1092
    [Documentation]  Test Case eE-1092 :: Version : 2 :: Reset Device from the GUI - Linux Guest Crashes
    ...             Verify that too many Guest Crashes that stop a VM from booting, can be cleared by clicking the "Reset Device" button in the GUI
    #[Tags]  zTC100iSingle, zTC110iSingle, zTC100iDual, zTC110iDual,  everRun
    [Tags]  DT4
    LoginPage.Log in to EverRun  ${USER}  ${PWD}
    #VM-Page.Go To VM Page
    #VM-Page.SVVSIR  ${T1092_VMNAME}
    VM-Page.Select VM Verify State Is Running  ${T1092_VMNAME}
    #CommonWeb.Reload Application Page
    VM-Page.Select VM Verify Button Is Disabled  ${T1092_VMNAME}  ${ResetDeviceButton}
    RemoteExec.Open Connection And Log In  ${REMOTE-HOST}  ${REMOTE-USER}  ${REMOTE-PASSWORD}
    RemoteExec.Put File To The Remote Server  ${T1092_SourceFile}  ${T1092_TargetDir}  ${T1092_Mode}
    RemoteExec.Execute Command And Verify Return Code  ${T1092_CmdLine}
    Builtin.Wait Until Keyword Succeeds  12 min  1 min  Element Should Be Enabled  ${ResetDeviceButton}
    VM-Page.Select VM Verify Button Is Enabled  ${T1092_VMNAME}  ${ResetDeviceButton}
    VM-Page.Hit Reset Device and Confirm
    Sleep  5 minutes  reason=Allow some time for the VM to return to running state
    VM-Page.Select VM Verify Button Is Disabled  ${T1092_VMNAME}  ${ResetDeviceButton}
    VM-Page.Verify VM Is Started  ${T1092_VMNAME}
    Set Test Variable  ${Remote_OutputFile}  ${T1092_OutputFile}
    Set Test Variable  ${Local_Destination_Dir}  ${T1092_Destination}


