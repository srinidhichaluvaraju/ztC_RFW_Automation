#Suite Variables file -- Contains various variable declarations for every Test Case of the Test Suite.

*** Variables ***
#Dummy Test Case
#[T19191]
${T19191-SourceFile} =  C:\\PyHeaven\\addthemup.sh
${T19191-TargetDir} =  /root/
${T19191-Mode} =  0777
${T19191-CmdLine} =  dos2unix /root/addthemup.sh;/root/addthemup.sh 99
${T19191-OutputFile} =  addnums.output
${T19191-Destination} =  C:\\Users\\akumar1\\

#[eE-848]
${T848_VMNAME} =  AS-CentOS76
#${T848_SourceFile} =  C:\\Users\\akumar1\\PycharmProjects\\EverRun\\Tests\\Scripts\\T848.sh
${T848_SourceFile} =  ${EXECDIR}\\Tests\\Scripts\\T848.sh
${T848_TargetDir} =  /root/
${T848_Mode} =  0777
${T848_OutputFile} =  /root/T848-SS.output
${T848_CmdLine} =  dos2unix /root/T848.sh;/root/T848.sh ${T848_VMNAME} > ${T848_OutputFile} 2>&1 &
${T848_Destination} =  ${EXECDIR}\\Temp\\
#${T848_Destination} =  C:\\Users\\akumar1\\
${T848_CustomPrompt} =  [node0-node0] ~ $
${T848_TimeOut} =  15 min

#[eE-849]
${T849_VMNAME-1} =  AS-CentOS76
${T849_VMNAME-2} =  OS-CentOS76
${T849_SourceFile} =  ${EXECDIR}\\Tests\\Scripts\\T849.sh
${T849_TargetDir} =  /root/
${T849_Mode} =  0777
${T849_OutputFile} =  /root/T849-SS.output
${T849_CmdLine-1} =  dos2unix /root/T849.sh;/root/T849.sh ${T849_VMNAME-1}  >> ${T849_OutputFile} 2>&1  &  /root//T849.sh ${T849_VMNAME-2} >> ${T849_OutputFile} 2>&1
${T849_CmdLine-2} =  /root/T849.sh ${T849_VMNAME-1} ${T849_VMNAME-2} >> ${T849_OutputFile} 2>&1
${T849_Destination} =  ${EXECDIR}\\Temp\\
${T849_CustomPrompt} =  [node0-node0] ~ $
${T849_TimeOut} =  15 min

#eE-1091
${T1091_VMNAME} =  MyWin7
${T1091_SourceFile} =  ${EXECDIR}\\Tests\\Scripts\\T1091.sh
${T1091_TargetDir} =  /root/
${T1091_Mode} =  0777
${T1091_OutputFile} =  /root/T1091-SS.output
${T1091_CmdLine} =  dos2unix /root/T1091.sh;/root/T1091.sh ${T1091_VMNAME}  >> ${T1091_OutputFile} 2>&1
${T1091_Destination} =  ${EXECDIR}\\Temp\\

#eE-1092
${T1092_VMNAME} =  OS-CentOS76
${T1092_SourceFile} =  ${EXECDIR}\\Tests\\Scripts\\T1092.sh
${T1092_TargetDir} =  /root/
${T1092_Mode} =  0777
${T1092_OutputFile} =  /root/T1092-SS.output
${T1092_CmdLine} =  dos2unix /root/T1092.sh;/root/T1092.sh ${T1092_VMNAME}  >> ${T1092_OutputFile} 2>&1
${T1092_Destination} =  ${EXECDIR}\\Temp\\