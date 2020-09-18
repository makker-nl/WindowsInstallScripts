@echo off
setlocal
set CMD_LOC=%~dp0
set CURRENT_DIR=%CD%
set SOFTWARE_HOME=x:\SOFTWARE\Software
set READYAPI_INSTALL_HOME=%SOFTWARE_HOME%\ReadyAPI
set READYAPI_VER=2.5.0
set READYAPI_INSTALLER=%READYAPI_INSTALL_HOME%\ReadyAPI-x64-%READYAPI_VER%.exe
set READYAPI_HOME=c:\Program Files\SmartBear\ReadyAPI-%READYAPI_VER%
set READYAPI_BIN=%READYAPI_HOME%\bin
set READYAPI_LIB=%READYAPI_HOME%\lib
set READYAPI_EXT=%READYAPI_BIN%\ext
set HERMES_ZIP=%READYAPI_INSTALL_HOME%\hermesJMS.zip
set HERMES_HOME=C:\Utils\hermesJMS
set HERMES_LIB=%HERMES_HOME%\lib
set HERMES_AQLIB=%HERMES_LIB%\oracleaq
set HERMES_CFG_HOME=c:\.hermes
set CMD_LIB=%CMD_LOC%\ext
set OJDBC_SRCLIB=%CMD_LIB%\ojdbc8
set OJDBC_JAR=ojdbc8.jar
rem set OJDBC_SRCLIB=ojdbc8
rem set OJDBC_JAR=ojdbc8.jar

rem Install ReadyAPI
if not exist "%READYAPI_HOME%" (
  echo Install ReadyAPI %READYAPI_VER% in %READYAPI_HOME%.
  echo Run "%READYAPI_INSTALLER%"
  cd %READYAPI_INSTALL_HOME%
  start /wait %READYAPI_INSTALLER% -q -c -overwrite
  if exist "%READYAPI_HOME%" (
    echo ReadyAPI %READYAPI_VER% succesfully installed in %READYAPI_HOME%.
    rem Copy settings
    echo Copy "%CMD_LOC%\soapui-settings.xml" naar "%USERPROFILE%"
    copy "%CMD_LOC%\soapui-settings.xml" "%USERPROFILE%" /Y
    echo Copy "%CMD_LOC%\ReadyAPI.vmoptions" naar "%READYAPI_BIN%"
    copy "%CMD_LOC%\ReadyAPI.vmoptions" "%READYAPI_BIN%" /Y
    rem Copy Jar files.   
    rem echo Copy "%OJDBC_SRCLIB%\%OJDBC_JAR%" naar "%READYAPI_EXT%"
    rem copy "%OJDBC_SRCLIB%\%OJDBC_JAR%" "%READYAPI_EXT%" /Y
    rem echo Copy "%OJDBC_SRCLIB%\aqapi.jar" naar "%READYAPI_EXT%"
    rem copy "%OJDBC_SRCLIB%\aqapi.jar" "%READYAPI_EXT%" /Y
    echo Copy "%OJDBC_SRCLIB%\%OJDBC_JAR%" naar "%READYAPI_LIB%"
    copy "%OJDBC_SRCLIB%\%OJDBC_JAR%" "%READYAPI_LIB%" /Y
    echo Copy "%OJDBC_SRCLIB%\aqapi.jar" naar "%READYAPI_LIB%"
    copy "%OJDBC_SRCLIB%\aqapi.jar" "%READYAPI_LIB%" /Y
    echo Copy "%CMD_LIB%\jsch-0.1.54.jar" naar "%READYAPI_EXT%"
    copy "%CMD_LIB%\jsch-0.1.54.jar" "%READYAPI_EXT%" /Y
  ) else (
    echo Install of ReadyAPI %READYAPI_VER% apparently failed!
  )
) else (
  echo ReadyAPI %READYAPI_VER% already installed in %READYAPI_HOME%.
)
rem Install HermesJMS
if not exist "%HERMES_HOME%" (
  echo Install HermesJMS in %HERMES_HOME%.
  echo Check if HermesJMS zip exist.
  if exist "%HERMES_ZIP%" (
    echo Create folder %HERMES_HOME%
    mkdir %HERMES_HOME%
    cd %HERMES_HOME%\..
    echo Unzip HermesJMS %HERMES_ZIP% into %HERMES_HOME%
    "%JAVA_HOME%"\bin\jar.exe -xf %HERMES_ZIP% 
    cd %CURRENT_DIR%
    rem Replace hermes.bat
    echo Copy "%CMD_LOC%\hermes.bat" naar "%HERMES_HOME%/bin"
    copy "%CMD_LOC%\hermes.bat" "%HERMES_HOME%/bin" /Y
    rem Copy Hermes config
    echo Create folder  %HERMES_CFG_HOME%
    mkdir %HERMES_CFG_HOME%
    echo Copy "%CMD_LOC%\hermes-config.xml" naar "%HERMES_CFG_HOME%"
    copy "%CMD_LOC%\hermes-config.xml" "%HERMES_CFG_HOME%" /Y
    rem Copy Jar files.
    echo Create folder %HERMES_AQLIB%
    mkdir %HERMES_AQLIB%
    echo Copy "%OJDBC_SRCLIB%\%OJDBC_JAR%" naar "%HERMES_AQLIB%"
    copy "%OJDBC_SRCLIB%\%OJDBC_JAR%" "%HERMES_AQLIB%" /Y
    echo Copy "%OJDBC_SRCLIB%\aqapi.jar" naar "%HERMES_AQLIB%"
    copy "%OJDBC_SRCLIB%\aqapi.jar" "%HERMES_AQLIB%" /Y
  ) else (
    echo Zipfile with HermesJMS %HERMES_ZIP% does not exist.
  )
) else (
  echo HermesJMS already installed in %HERMES_HOME%.
)
endlocal
echo Done.