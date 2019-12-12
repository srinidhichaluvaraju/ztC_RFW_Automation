#############################################################################################################################
########   This robot script contains keywords defined to configure VM Devices. Allows us to enable and disable     #########
########   the insertion of the CDs and USBs to the VMs. This feature is present in both everRun and ztC            #########
#############################################################################################################################


*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Library  String
Library  DateTime

*** Variables ***
${Disable_CD_Checkbox} =    //*[@id="ext-comp-1274"]
${Disable_USB_Checkbox} =   //*[@id="ext-comp-1275"]
${Save_Button}  =           //*[@id="ext-gen1533"]/span
${Unsaved_msg}  =           //*[@id="ext-comp-1280"]
${Help_Page}    =           //*[@id="ext-gen622"]
${VM_Device_Config} =       //*[@id="vmDeviceConfigNav"]
${VM_Dev_Config_Page} =     //*[@id="vmDeviceConfig"]

*** Test Cases ***
Test title
    [Tags]    DEBUG
    Provided precondition
    When action
    Then check expectations

*** Keywords ***
Provided precondition
    Setup system under test