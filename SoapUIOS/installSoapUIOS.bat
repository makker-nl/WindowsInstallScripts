@echo off
setlocal
set CMD_LOC=%~dp0
set CURRENT_DIR=%CD%
set SOFTWARE_HOME=x:\SOFTWARE\Software
set SOAPUI_INSTALL_HOME=%SOFTWARE_HOME%\SoapUI
set SOAPUI_VER=5.5.0
set SOAPUI_INSTALLER=%SOAPUI_INSTALL_HOME%\SoapUI-x64-%SOAPUI_VER%.exe
set SOAPUI_HOME=c:\Program Files\SmartBear\SoapUI-%SOAPUI_VER%
set SOAPUI_BIN=%SOAPUI_HOME%\bin
set SOAPUI_LIB=%SOAPUI_HOME%\lib
set SOAPUI_EXT=%SOAPUI_BIN%\ext
set CMD_LIB=%CMD_LOC%\ext
set OJDBC_SRCLIB=%CMD_LIB%\ojdbc8
set OJDBC_JAR=ojdbc8.jar
rem set OJDBC_SRCLIB=ojdbc6
rem set OJDBC_JAR=ojdbc6.jar

rem Install SOAPUI
if not exist "%SOAPUI_HOME%" (
  echo Install SOAPUI %SOAPUI_VER% in %SOAPUI_HOME%.
  echo Run "%SOAPUI_INSTALLER%"
  cd %SOAPUI_INSTALL_HOME%
  start /wait %SOAPUI_INSTALLER% -q -c -overwrite
  if exist "%SOAPUI_HOME%" (
    echo SOAPUI %SOAPUI_VER% succesfully installed in %SOAPUI_HOME%.
    rem Copy Jar files. De ojdbc en aqapi jars moeten naar de lib, niet naar de bin-ext folder.
    echo Copy "%OJDBC_SRCLIB%\%OJDBC_JAR%" naar "%SOAPUI_LIB%"
    copy "%OJDBC_SRCLIB%\%OJDBC_JAR%" "%SOAPUI_LIB%" /Y
    echo Copy "%OJDBC_SRCLIB%\aqapi.jar" naar "%SOAPUI_LIB%"
    copy "%OJDBC_SRCLIB%\aqapi.jar" "%SOAPUI_LIB%" /Y    
    echo Copy "%CMD_LIB%\jsch-0.1.54.jar" naar "%SOAPUI_EXT%"
    copy "%CMD_LIB%\jsch-0.1.54.jar" "%SOAPUI_EXT%" /Y
  ) else (
    echo Install of SOAPUI %SOAPUI_VER% apparently failed!
  )
) else (
  echo SOAPUI %SOAPUI_VER% already installed in %SOAPUI_HOME%.
)
endlocal
echo Done.