*** Settings ***
Documentation    Virtual CDs Page Object catering to various Test processes performed on the zTC/everRun Virtual CDs Page.
Library  SeleniumLibrary
#Library  String

*** Variables ***

${VCDPageNav} =  id:vcdNav
${VCDPageTitle} =  xpath://*[@class="vcdTitle viewTitle"]

*** Keywords ***

Go To VCD Page
    Click Element  ${VCDPageNav}
    Wait Until Page Contains Element  ${VCDPageTitle}
    sleep  10s
    Element Text Should Be  ${VCDPageTitle}  VIRTUAL CDS  ignore_case=True
    Page Should Contain Element  xpath://*[contains(text(),"Virtual CDs")]