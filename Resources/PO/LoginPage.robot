*** Settings ***
Library  SeleniumLibrary

*** Variables ***

${LOGIN_BOX_ELEMENT} =  css=body > div.login-box.brand-color
${USERNAME_TEXTBOX} =  css=#username
${PASSWORD_TEXTBOX} =  css=#password
${LOGIN_BUTTON} =  css=#login-btn
${STRATUS_BANNER} =  css=#ext-gen21

*** Keywords ***

Navigate To
    Go To  ${URL}
    Sleep  3s

Verify Page Loaded
    Wait Until Page Contains Element  ${LOGIN_BOX_ELEMENT}

Log in to EverRun
    [Arguments]  ${USER}  ${PWD}
    Input Text  ${USERNAME_TEXTBOX}  ${USER}
    Input Password  ${PASSWORD_TEXTBOX}  ${PWD}
    Click Link  ${LOGIN_BUTTON}
    ${status} =  Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${STRATUS_BANNER}
    Run Keyword If  ${status}=='PASS'  Log  Logged in successfully.







