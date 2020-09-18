@echo off
set CMD_LOC=%~dp0
set CURRENT_DIR=%CD%
SETLOCAL
set SOFTWARE_HOME=x:\SOFTWARE\Software
set MXTERM_INSTALL_HOME=%SOFTWARE_HOME%\\MobaXterm
set MXTERM_NAME=MobaXterm_Portable_v20.3
set MXTERM_ZIP=%MXTERM_INSTALL_HOME%\%MXTERM_NAME%.zip
set MXTERM_BASE=c:\Utils
set MXTERM_HOME=%MXTERM_BASE%\%MXTERM_NAME%
set CMD_LIB=%CMD_LOC%\ext
rem Install MobaXterm
if not exist "%MXTERM_HOME%" (
  echo MobaXterm does not yet exist in "%MXTERM_HOME%".
  if exist "%MXTERM_ZIP%" (
    echo Install MobaXterm in %MXTERM_HOME%.
    mkdir %MXTERM_HOME%
    cd %MXTERM_HOME%
    echo Unzip MobaXterm "%MXTERM_ZIP%" into %MXTERM_HOME%
    "%JAVA_HOME%"\bin\jar.exe -xf "%MXTERM_ZIP%"
    cd %CURRENT_DIR%
  ) else (
    echo MobaXterm zip  "%MXTERM_ZIP%" does not exist!
  )
) else (
  echo MobaXterm already installed in %MXTERM_HOME%.
)
echo Done.
ENDLOCAL
