#Common Library file.
import configparser
from subprocess import *
from time import sleep
config = configparser.ConfigParser()
from  shutil import copyfile, rmtree
import logging, os, sys

#Global variables for all modules.
BACKUP=True
INTERACTIVE=False
CLIENT=False
CWD=os.path.abspath(os.path.dirname(sys.argv[0]))   #Get calling (invoking) scripts' working directory

def GetDFSec2Dict(DataFile, InfoSection):
    Lconfig = configparser.ConfigParser()
    Lconfig.optionxform = str
    LInfoSection = {}
    Lconfig.read(DataFile)
    # print self.Lconfig.sections()
    if Lconfig.has_section(InfoSection):
        LInfoSection = dict(Lconfig.items(InfoSection))
    else:
        print("No such section found in the config file %s : %s ")  % (DataFile, InfoSection)

    return LInfoSection

def GetDFWithoutSec2Dict(DataFile):
    Lconfig = configparser.ConfigParser()
    Lconfig.optionxform = str
    LInfoSection = {}
    with open(DataFile) as f:
        file_content = '[DEFAULT]\n' + f.read()
    Lconfig.read_string(file_content)
    LInfoSection = dict(Lconfig.items('DEFAULT'))
    return LInfoSection
       
def RunCMD(CmdToRun,outfile=None,errfile=None):
    logging.debug("Executing the command in the OS shell : %s " % CmdToRun)
    P = Popen(CmdToRun, stdout=PIPE, stderr=PIPE, universal_newlines=True, shell=True)
    output=P.communicate()[0]
    error = P.communicate()[1]
    retcode=P.returncode
    print(output)
    if outfile:
        print(output,file=outfile)
    if errfile:
        print(error,file=errfile)
    #print(P.stdout)
    #print(p.stderr)
    #output or P.stdout in the below command?
    ExecResults={'CmdStdOut':output, 'CmdStdErr':error, 'ReturnCode':retcode}
    logging.debug("Execution Results=%s" % ExecResults)
    return ExecResults

def CopyFile(SrcFile, DestFile):
    try:
        copyfile(SrcFile, DestFile)
        return 0
    except IOError as IE:
        print("Copying the file %s  failed : %s " % (SrcFile , IE))
        return IE.errno

def AssertNotEmpty(VarToCheck):
    try :
        assert VarToCheck
    except AssertionError as AE:
        logging.debug("%s seems to be empty or None" % VarToCheck)
        return AE

def Copy_All_Files(SrcDir,DestDir):
    Src_Files = os.listdir(SrcDir)
    for file_name in Src_Files:
        Full_File_Name = os.path.join(SrcDir, file_name)
        if (os.path.isfile(Full_File_Name)):
            logging.debug("Copying %s file to %s directory..." % (Full_File_Name, DestDir))
            copyfile(Full_File_Name, DestDir)


def Delete_DB_Files(DirName,FileName="",ExtList=()):
    DIRPATH=DirName
    AssertNotEmpty(DIRPATH)
    if os.path.isdir(DIRPATH):
        logging.debug("Deleting files from %s directory" % DIRPATH)
        for the_file in os.listdir(DIRPATH):
            file_path = os.path.join(DIRPATH, the_file)
            try:
                if os.path.isfile(file_path):
                    if (the_file==FileName) or (the_file.lower().endswith(ExtList)):
                        logging.debug("Deleting %s" % file_path)
                        os.unlink(file_path)
                    elif (FileName=="") and (ExtList==()):
                        logging.debug("Deleting %s" % file_path)
                        os.unlink(file_path)
                    #elif os.path.isdir(file_path): shutil.rmtree(file_path)
            except Exception as e:
                print(e)

def Write_Lines_To_File(FileName, List_of_Lines):
    with open(FileName, 'w') as f:
        print("Writing to the file %s the following lines: " % FileName)
        for Line in List_of_Lines:
            print(Line)
            print(Line,file=f)
        print("Done.")
        
def Create_DestDir_Join_Filename(DirName,FileName):
    AssertNotEmpty(DirName)
    AssertNotEmpty(FileName)
    
    if not os.path.isdir(DirName):
        print("Directory %s does not exists! Creating the required directory path..." % DirName)
        try:  
            os.makedirs(DirName)
        except OSError:  
            print("Creation of the directory %s failed" % DirName)
        else:  
            print("Successfully created the directory %s" % DirName)
    #
    Full_File_Name = os.path.join(DirName, FileName)
    print("Absolute path of the requested file is %s " % Full_File_Name)
    return Full_File_Name
    
    
        