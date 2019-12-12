Library  SeleniumLibrary
Library  String

*** Variables ***
#${PMPageNav} =  id:pmNav
#${PMPageTitle} =  xpath://*[@class="pmTitle viewTitle"]
#${Work_OnButton} =  xpath://*[@class=" x-btn-text pm-workon-cmd-icon"]
#${FinalizeButton} =  xpath://*[@class=" x-btn-text pm-finalize-cmd-icon"]
#${YesButton} =  xpath://*[@class="smux-l10n " and contains(text(),'Yes')]
#${ShutDownPMButton} =  xpath://*[@class=" x-btn-text pm-shutdown-cmd-icon"]
#${RebootPMButton} =  xpath://*[@class=" x-btn-text pm-reboot-cmd-icon"]

${MastheadCritical} =  xpath://*[@class="masthead-unit-state masthead-unit-state-critical"]
${MsgMastheadSeriousAlert} =  xpath://*[@class="smux-l10n " and contains(text(),'Serious Alert')]
${MsgMastheadAlert} =  xpath://*[@class="smux-l10n " and contains(text(),'Alert')]

*** Keywords ***

Verify Masthead Unit State Is Critical
    [Arguments]  ${AlertMsg}
    Log  Verifying if the Masthead Unit State icon is corresponding to Critical state.
    Wait Until Keyword Succeeds  3 min  30 sec  Element Should Be Visible  ${MastheadCritical}
    Element Should Be Visible  ${AlertMsg}

