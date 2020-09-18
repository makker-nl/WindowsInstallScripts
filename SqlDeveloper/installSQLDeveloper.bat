@echo off
set CMD_LOC=%~dp0
set CURRENT_DIR=%CD%
SETLOCAL
set SOFTWARE_HOME=x:\SOFTWARE\Software
set SQLDEV_INSTALL_HOME=%SOFTWARE_HOME%\SQL Developer
set SQLDEV_NAME=sqldeveloper-20.2.0.175.1842-no-jre
set SQLDEV_ZIP=%SQLDEV_INSTALL_HOME%\%SQLDEV_NAME%.zip
set SQLDEV_BASE=c:\Oracle\SQLDeveloper
set SQLDEV_HOME=%SQLDEV_BASE%\%SQLDEV_NAME%
set SQLDEV_USERDIR=%USERPROFILE%\AppData\Roaming\SQL Developer
set CMD_LIB=%CMD_LOC%\ext
rem Install SqlDeveloper
if not exist "%SQLDEV_HOME%" (
  echo SqlDeveloper does not yet exist in "%SQLDEV_HOME%".
  if exist "%SQLDEV_ZIP%" (
    echo Install SqlDeveloper in %SQLDEV_HOME%.
    if not exist "%SQLDEV_BASE%" (
      echo Create folder %SQLDEV_BASE%
      mkdir %SQLDEV_BASE%
    )
    cd %SQLDEV_BASE%
    echo Unzip SqlDeveloper "%SQLDEV_ZIP%" into %SQLDEV_BASE%
    "%JAVA_HOME%"\bin\jar.exe -xf "%SQLDEV_ZIP%"
    echo Rename unzipped folder "sqldeveloper" to %SQLDEV_NAME%
    rename sqldeveloper %SQLDEV_NAME%
    rem Deze library wordt verwacht in de Java home, maar komt blijkbaar niet meer standaard mee. 
    if not exist "%JAVA_HOME%\jre\bin\msvcr100.dll" (
      echo Copy msvcr100.dll from c:\Windows\System32\ to "%JAVA_HOME%\jre\bin"
      copy c:\Windows\System32\msvcr100.dll "%JAVA_HOME%\jre\bin"
    ) else (
      echo Library "%JAVA_HOME%\jre\bin\msvcr100.dll" already exists.
    )
    if not exist "%SQLDEV_USERDIR%" (
      echo Create folder "%SQLDEV_USERDIR%"
      mkdir "%SQLDEV_USERDIR%"
    )
    if not exist "%SQLDEV_USERDIR%\UserSnippets.xml" (
      echo Copy "%CMD_LOC%\UserSnippets.xml" naar "%SQLDEV_USERDIR%"
      copy "%CMD_LOC%\UserSnippets.xml" "%SQLDEV_USERDIR%" /Y
    ) else (
      echo User Snippets "%SQLDEV_USERDIR%\UserSnippets.xml" already exists.
    )
    cd %CURRENT_DIR%
  ) else (
    echo SqlDeveloper zip  "%SQLDEV_ZIP%" does not exist!
  )
) else (
  echo SqlDeveloper already installed in %SQLDEV_HOME%.
)
echo Done.
ENDLOCAL
