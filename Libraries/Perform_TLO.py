from TestLinkOps import *
import CommonLibrary as CL

CFName=r'C:\Users\akumar1\PycharmProjects\EverRun\Libraries\TestLink.Config'
SectionHeading='TestLink-Info'
TCData=CL.GetDFSec2Dict(CFName, SectionHeading)
global TLOObj

def Get_TLO_Object():
    TLOObjectName = TestLinkOps()
    return TLOObjectName

def Set_TLO_Object():
    print('Obtaining a TestLink Operations Object and assigning it to a holder...')
    global TLOObj
    TLOObj = Get_TLO_Object()
    print("Done.")

def Update_TestLink(TCName, TCEResult):
    print("Preparing to update test case execution results directly on TestLink application...")
    TCUpdateSet = {key: TCData[key] for key in
                   TCData.keys() & {'TesterName', 'TestPlanID', 'BuildName', 'PlatformID', 'TestNotes'}}
    TCUpdateSet['TestCaseID'] = TCName
    TCUpdateSet['TCEResult'] = TCEResult
    global TLOObj
    TC_Info = TLOObj.ReportTestResult(**TCUpdateSet)
    print(TC_Info)

def update_test_result_on_testlink(TCName, TCEResult):
    Set_TLO_Object()
    Update_TestLink(TCName, TCEResult)
    print("Test Link is updated for Test Case %s with result %s " % (TCName, TCEResult))
