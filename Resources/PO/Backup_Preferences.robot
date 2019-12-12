*** Settings ***
Library  SeleniumLibrary
Library  String
Library  DateTime


*** Variables ***
${LOGIN_BOX_ELEMENT} =  css=body > div.login-box.brand-color
${USERNAME_TEXTBOX} =  css=#username
${PASSWORD_TEXTBOX} =  css=#password
${LOGIN_BUTTON} =  css=#login-btn
${STRATUS_BANNER} =  css=#ext-gen21
${PreferencesPageNav} =                         //*[@id="configNav"]
${BackupPreferences_Tab} =                      //*[@id="prefBackupNav"]
${BackupPreferences_Page} =                     //*[@id="prefBackup"]
${BackupPreferences_Description} =              //*[@id="ext-comp-1243"]
${BackupPreferences_FileName} =                 //*[@id="ext-comp-1242"]
${BackupPreferences_Tag1} =                     //*[@id="tag1"]
${BackupPreferences_Tag2} =                     //*[@id="tag2"]
${BackupPreferences_Tag3} =                     //*[@id="tag3"]
${BackupPreferences_MyComputer} =               //*[@id="ext-comp-1239"]
${BackupPreferences_ztCCloudFolder} =           //*[@id="ext-comp-1240"]
${BackupPreferences_CloudCredentialPanel} =     //*[@id="ext-gen1248"]
${BackupPreferences_CloudCredentialUser} =      //*[@id="cloudUser"]
${BackupPreferences_CloudCredentialPwd} =       //*[@id="cloudPwd"]
${BackupPreferences_Save} =                     //*[@id="ext-comp-1241"]/tbody/tr[2]/td[2]  #//*[@class="smux-l10n " and contains(text(),"Save")]
${BackupPreferences_Clear} =                    //*[@class="smux-l10n " and contains(text(),"Clear")]
${BackupPreferences_Help} =                     //*[@id="ext-comp-1097"]
${URL}     http://10.71.122.12
${USER}    admin
${PWD}     admin_Test
${BROWSER}      gc
${sys_name}     QA122

*** Keywords ***

Go To Backup-Preferences Page
    [Documentation]  This Keyword Takes you to the Backup-Preferences page and also validates the contents of the page.
    log to console      Starting Backup-Process
    Click Element       ${PreferencesPageNav}
    Sleep               10 sec
    Click Element       ${BackupPreferences_Tab}
    Page should contain element   ${BackupPreferences_Page}
    log to console      Backup-Preferences Page Loaded!!!

Go To Backup-Preferences Help-Page
   [Documentation]  This Keyword just launches the Backup-Preferences help page...
   log to console       Loading Help-Page...
   Click Element        ${BackupPreferences_Help}
   @{list1}             get window handles
   Select window        @{list1}[1]
   Wait until page contains element     xpath://*[@id="contentBody"]
   Sleep    10 sec

Add Description and Tags
   [Documentation]  This Keyword adds some description and Tags to your backup.zip file. In this case, the sys_name is nothing but system name. And timestamp is appended to you description so as to identify your backup file among many.
   ${timestamp} =   Get current date
   log to console       Adding Description & Tags...
   Input text           ${BackupPreferences_Description}    ${sys_name}_${timestamp}
   Get text             ${BackupPreferences_Description}
   Input Text           ${BackupPreferences_Tag1}   Tag_1
   Input Text           ${BackupPreferences_Tag2}   Tag_2
   Input Text           ${BackupPreferences_Tag3}   Tag_3
   sleep  10 sec

Clear Description and Tags
   [Documentation]  This Keyword clears off the added description and tags. Can even help you to test the clear button feature.
   Add Description and Tags
   Click Element         ${BackupPreferences_Clear}
   sleep   5 sec
   ${clear_desc} =   Get text       ${BackupPreferences_Description}
   Should be empty   ${clear_desc}

Save Backup-Preferences to Mycomputer
   [Documentation]  This Keyword saves your Backup-Preferences.zip to your local directory on "My Computer"
   log to console       Lets try to save to MyComputer...
   Click Element       ${BackupPreferences_Save}
   sleep    2 sec
   ${response}=    Get Text    xpath://*[@id="saveStatus"]
   Should Be Equal As Strings    ${response}    Backup file generated successfully.
   sleep    10 sec

Save Backup-Preferences to ztC Cloud Folder
    [Documentation]  This Keyword saves your Backup-Preferences.zip on "ztC Cloud Folder"
    log to console       Lets try to save to ztC CLoud Folder...
    Click Element       ${BackupPreferences_ztCCloudFolder}
    sleep   5 sec
    Wait until page contains element     ${BackupPreferences_CloudCredentialPanel}
    sleep   5 sec
    Input text          ${BackupPreferences_CloudCredentialUser}   Cust1FName.Cust1LName@test.com
    Input text          ${BackupPreferences_CloudCredentialPwd}    new_pwd
    sleep   5 sec
    ${Backup_File} =    Get Text            //*[@id="ext-comp-1242"]
    sleep   5 sec
    ${timestamp} =      Get current date
    Input text          ${BackupPreferences_Description}    ${sys_name}_${timestamp}
    sleep   5 sec
    Click Element       ${BackupPreferences_Save}
    sleep   2 sec
    ${response1}=    Get Text    //*[@id="saveStatus"]
    Should be equal as strings      ${response1}       Backup file exported successfully.
    log to console      File Exported to cloud folder is :  ${Backup_File}


Launch everRun_or_ztC
    [Documentation]  This keyword helps you to launch your everRun/ztC application
    log to console      *****Starting test*****
    Open Browser        ${URL}      ${BROWSER}
    Maximize Browser Window

Log in to EverRun
   [Documentation]  This Keyword helps you to login to your everRun/ztC application
   Input Text  ${USERNAME_TEXTBOX}  ${USER}
   Input Password  ${PASSWORD_TEXTBOX}  ${PWD}
   Click Link  ${LOGIN_BUTTON}
   ${status} =  Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${STRATUS_BANNER}
   Run Keyword If  ${status}=='PASS'  Log  Logged in successfully.

End Web Test
    [Documentation]  Ths Keyword closes all the open session test-teardown
    Log To Console  Closing Browser
    Close All Browsers

*** Test Cases ***

Should be able to login to App
    [Documentation]  Testing ability to "Login" to EverRun App
    [Tags]  Sprint9
    Launch everRun_or_ztC
    Log in to EverRun

Should be able to Backup-Prefrences to MyComputer
    [Documentation]  Test to verify if the Backup-Preferences page is available to the user
    [Tags]  Sprint9
    Go To Backup-Preferences Page
    Add Description and Tags
    Save Backup-Preferences to Mycomputer

Should be able to clear descriptions and tags
    [Documentation]  Test to verify if the clear button clears off Description and Tags
    [Tags]  Sprint9
    Clear Description and Tags

Should be able to Backup-Preferences to CloudFolder
    [Documentation]  Test to verify if the backup-Preferences can be exported to ztC cloud folder
    [Tags]  Sprint9
    Save Backup-Preferences to ztC Cloud Folder

Should be able to launch Backup-Preferences Help-Page
    [Documentation]  Test to verify if the Backup-Preferences Help Page can be loaded
    [Tags]  Sprint9
    Go To Backup-Preferences Help-Page

End of Test Suite
    [Documentation]  Looks like all the tests were run
    [Tags]  sprint9
    End Web Test