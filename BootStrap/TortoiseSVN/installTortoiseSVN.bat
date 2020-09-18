@echo off
set TSVN_HOME=c:\Program Files\TortoiseSVN\
set SOFTWARE_HOME=x:\SOFTWARE\Software
set TSVN_INSTALL_HOME=%SOFTWARE_HOME%\SVN
set TSVN_INSTALLER_MSI=TortoiseSVN-1.14.0.28885-x64-svn-1.14.0.msi
set TSVN_INSTALLER=%TSVN_INSTALL_HOME%\%TSVN_INSTALLER_MSI%
set TSVN_INSTAL_LOG=TortoiseSVNInstall.log
@set SVN="%TSVN_HOME%\bin\svn"
@set WC_HOME=c:\Data\svn
@set SVN_HOST=http://svnserver.conclusion.local
@set SVN_BASE=%SVN_HOST%/svn
@set SI_URL_BASE=%SVN_BASE%/SysteemIntegratie
@set CI_URL=%SI_URL_BASE%/ContinuousIntegration
@set CI_WC=%WC_HOME%\ContinuousIntegration
rem Check the TortoiseSVN Installed with commandline tools.
if exist "%TSVN_HOME%\bin" (
  if exist "%TSVN_HOME%\bin\svn.exe" (
    goto :TSVN_HOME_EXISTS
  )
)
echo Tortoise nog niet geinstalleerd en/of commandline tools missen.
:CHECK_TSVN_INSTALLER
if exist "%TSVN_INSTALLER%" goto :TSVN_INSTALLER_EXISTS
echo Tortoise installer %TSVN_INSTALLER% niet gevonden!
goto :DONE_NOT_INSTALLED
:TSVN_INSTALLER_EXISTS
echo Tortoise installer %TSVN_INSTALLER% gevonden.
echo Silent run %TSVN_INSTALLER%
Msiexec /i %TSVN_INSTALLER% /qn ADDLOCAL="F_OVL,DefaultFeature,MoreIcons,CLI,CrashReporter,UDiffAssoc,DictionaryENGB,DictionaryENUS" /LP "%TSVN_INSTAL_LOG%"
if exist "%TSVN_HOME%\bin" (
  if exist "%TSVN_HOME%\bin\svn.exe" (
    goto :TSVN_HOME_EXISTS
  )
)
echo install blijkbaar gefaald!
goto :DONE_NOT_INSTALLED
:TSVN_HOME_EXISTS
echo TortoiseSVN Home %TSVN_HOME% bestaat.
if exist %CI_WC% goto :CI_WC_CHECKED_OUT
echo Workingcopy uitchecken: %CI_WC%
%SVN% checkout %CI_URL% %CI_WC%
goto :DONE
:CI_WC_CHECKED_OUT
echo Working copy %CI_WC% al uitgecheckt.
goto :DONE
:DONE_NOT_INSTALLED
echo Tortoise is not installed!
:DONE
echo Done