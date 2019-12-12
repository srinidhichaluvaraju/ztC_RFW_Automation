*** Settings ***
Library  SeleniumLibrary
Library  String

*** Variables ***
${PMPageNav} =  id:pmNav
${PMPageTitle} =  xpath://*[@class="pmTitle viewTitle"]
${Work_OnButton} =  xpath://*[@class=" x-btn-text pm-workon-cmd-icon"]
${FinalizeButton} =  xpath://*[@class=" x-btn-text pm-finalize-cmd-icon"]
${YesButton} =  xpath://*[@class="smux-l10n " and contains(text(),'Yes')]
${ShutDownPMButton} =  xpath://*[@class=" x-btn-text pm-shutdown-cmd-icon"]
${RebootPMButton} =  xpath://*[@class=" x-btn-text pm-reboot-cmd-icon"]



*** Keywords ***

Go To PM Page
    Click Element  ${PMPageNav}
    Wait Until Page Contains Element  ${PMPageTitle}
    sleep  10s
    Element Text Should Be  ${PMPageTitle}  PHYSICAL MACHINES  ignore_case=True
    Page Should Contain Element  xpath://*[contains(text(),"Physical Machines")]

Select a given PM
    [Arguments]  ${GIVEN_PM}
    Log  The given PM to be selected is ${GIVEN_PM}
    sleep  10s
    ${TargetPM} =  Get Table Element  ${GIVEN_PM}
    Scroll Element Into View  ${TargetPM}
    Click Element  ${TargetPM}
    Element Should Contain  ${TargetPM}  ${GIVEN_PM}  ignore_case=True

Hit Work On And Confirm
    Click Element  ${Work_OnButton}
    Sleep  5s
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Click Element  ${YesButton}
    sleep  60s

Hit Finalize And Confirm
    Click Element  ${FinalizeButton}
    Sleep  5s
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Click Element  ${YesButton}
    sleep  180s

Shutdown Selected PM
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${ShutDownPMButton}
    Element Should Be Enabled  ${ShutDownPMButton}
    Click Button  ${ShutDownPMButton}
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Click Element  ${YesButton}
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Click Element  ${YesButton}
    sleep  60s

Reboot Selected PM
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${RebootPMButton}
    Element Should Be Enabled  ${RebootPMButton}
    Click Button  ${RebootPMButton}
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${YesButton}
    Click Element  ${YesButton}
    sleep  120s

Which PM Is Primary
    Log  Searching the table for the node name that is currently primary...
    Set Test Variable  ${SearchStr1}  node0 (primary)
    Set Test Variable  ${SearchStr2}  node1 (primary)
    @{WebElmts} =  Get WebElements  xpath://table
    Set Test Variable  @{WebElmts}
    ${WebElmtsNum} =  Get Length  ${WebElmts}
    : FOR  ${a}  IN RANGE  ${WebElmtsNum}
    \    ${WebElmText} =  Get Text  @{WebElmts}[${a}]
    \    Log  ${WebElmText}
    \    Run Keyword If	'''${WebElmText}''' == ''  Continue For Loop
    \    ${stripped}=  Strip String  ${WebElmText}  mode=both
    \    @{lines} =	 Split To Lines  ${WebElmText}
    \    Run Keyword If  '${SearchStr1}' in @{lines}  Set Test Variable  ${PrimaryNode}  ${SearchStr1}
    \    Run Keyword If  '${SearchStr2}' in @{lines}  Set Test Variable  ${PrimaryNode}  ${SearchStr2}
    LOG  ${PrimaryNode}
    [Return]  ${PrimaryNode}

Get PM Table Row
    [Arguments]  ${Unique_ID}
    LOG  Getting a dictionary with key-value pairs from a PM Table row.
    @{WebElmts} =  Get WebElements  xpath://table
    Set Test Variable  @{WebElmts}
    @{RowValues} =  Set Test Variable  @{EMPTY}
    ${WebElmtsNum} =  Get Length  ${WebElmts}
    : FOR  ${a}  IN RANGE  ${WebElmtsNum}
    \    ${WebElmText} =  Get Text  @{WebElmts}[${a}]
    \    Log  ${WebElmText}
    \    Run Keyword If	'''${WebElmText}''' == ''  Continue For Loop
    \    ${stripped}=  Strip String  ${WebElmText}  mode=both
    \    @{lines} =	 Split To Lines  ${WebElmText}
    \    Run Keyword If  '${Unique_ID}' in @{lines}  Set Test Variable  @{RowValues}  @{lines}
    \    Run Keyword If  @{RowValues}==@{lines}  Exit For Loop
    \    ...    ELSE IF  '${Unique_ID}' not in @{lines}  Continue For Loop
    LOG Many  @{RowValues}
    [Return]  @{RowValues}

Strip Primary Word
    [Arguments]  ${NodeName}
    LOG  Stripping the given node name of Primary word. That is what we need to do when it is no longer Primary node.
    ${StrippedNN} =  Get Substring  ${NodeName}  0  5
    Log  ${StrippedNN}
    [Return]  ${StrippedNN}

Attach Primary Word
    [Arguments]  ${NodeName}
    LOG  Attaching the given node name with Primary word. That is what we need to do when it becomes the Primary node.
    ${EnhancedNN} =  Catenate  ${NodeName}  (primary)
    Log  ${EnhancedNN}
    [Return]  ${EnhancedNN}

Verify Given Node State In Maintenance
    [Arguments]  ${NodeName}  ${ExpStr}
    LOG  Verifying if ${NodeName} is in maintenance state (running in maintenance or powered off in maintenace). Verify all VMs have migrated out and the node is no longer primary.
    ${PrimaryNode} =  Which PM Is Primary
    Should Not Be Equal  ${NodeName}  ${PrimaryNode}
    ${NodeName} =  PM-Page.Strip Primary Word  ${NodeName}
    @{RetrievedValues} =  Get PM Table Row  ${NodeName}
    #Set Test Variable  ${ExpStr}  Maintenance
    Run Keyword If  '${ExpStr}' in @{RetrievedValues}  Log  ${ExpStr} found in @{RetrievedValues}
    Should Be Equal  @{RetrievedValues}[-1]  0

Verify Given Node Moves To Normal
    [Arguments]  ${NodeName}
    LOG  Verifying if ${NodeName} has moved to Normal state from maintenance state.
    ${PrimaryNode} =  Which PM Is Primary
    Should Not Be Equal  ${NodeName}  ${PrimaryNode}
    #${NodeName} =  PM-Page.Strip Primary Word  ${NodeName}
    @{RetrievedValues} =  Get PM Table Row  ${NodeName}
    Set Test Variable  ${ExpStr}  running
    Run Keyword If  '${ExpStr}' in @{RetrievedValues}  Log  ${ExpStr} found in @{RetrievedValues}

#ToDo  yum install dos2unix -y   --  install on both nodes in suite setup.



