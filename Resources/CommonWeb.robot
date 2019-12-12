*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Keywords ***

Begin Web Test
    Log To Console  Starting
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Set Log Level  Debug
#    ${SeleniumSpeedOriginal} =  Set Selenium Speed  0.5 seconds

End Web Test
    LOG  ${TEST_STATUS}
    Run Keyword If Test Passed  set test variable  ${Status}  p
    Run Keyword If Test Failed  set test variable  ${Status}  f
    #update test result on testlink  ${TEST_NAME}  ${Status}
    Run Keyword If Test Passed  Download Output File
#    Set Selenium Speed  ${SeleniumSpeedOriginal}
    Log To Console  Closing Browser
    Close All Browsers

Identify And Click Element
    [Arguments]  ${locator}
    Wait Until Element Is Enabled  ${locator}
    Set Focus To Element  ${locator}
    Click Element  ${locator}

Reload Application Page
    Log  Reloading the application browser page
    Reload Page
    Sleep  10s

Download Output File
    Log  Downloading the output file from the remote server's source directory
    RemoteExec.Get File From The Remote Server  ${Remote_OutputFile}  ${Local_Destination_Dir}

Go Back To Previous Page
    Log  Go back to immediately previous page - equal to hitting back button on the browser.
    Go Back
    Sleep  5s
