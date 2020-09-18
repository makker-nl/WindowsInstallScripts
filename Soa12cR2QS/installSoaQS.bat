@echo off
rem Part 1: Settings
rem set JAVA_HOME=c:\Oracle\Java\jdk8
set JAVA_HOME=c:\Program Files\Java\jdk1.8.0_261
set SOFTWARE_HOME=x:\SOFTWARE\Software
set JDK8_INSTALL_HOME=%SOFTWARE_HOME%\Java\JDK8
set JAVA_INSTALLER=%JDK8_INSTALL_HOME%\jdk-8u261-windows-x64.exe
rem set FMW_HOME=C:\oracle\JDeveloper\12213_SOAQS
set QS_INSTALL_HOME=%SOFTWARE_HOME%\Oracle\SOAQuickStart12.2.1.3
set QS_EXTRACT_HOME=%TEMP%\Oracle\SOAQuickStart12.2.1.3
set FMW_HOME=C:\oracle\JDeveloper\12213_SOAQS
set QS_RSP=soaqs1221_silentInstall.rsp
set QS_RSP_TPL=%QS_RSP%.tpl
set QS_JAR=fmw_12.2.1.3.0_soa_quickstart.jar
set QS_ZIP=%QS_INSTALL_HOME%\fmw_12.2.1.3.0_soaqs_Disk1_1of2.zip
set QS_JAR2=fmw_12.2.1.3.0_soa_quickstart2.jar
set QS_ZIP2=%QS_INSTALL_HOME%\fmw_12.2.1.3.0_soaqs_Disk1_2of2.zip
set QS_USER_DIR=c:\Data\JDeveloper\SOA
set CMD_LOC=%~dp0
set CURRENT_DIR=%CD%
rem Part 2: Install Java
rem Set JAVA_HOME
echo setx -m JAVA_HOME "%JAVA_HOME%"
setx -m JAVA_HOME "%JAVA_HOME%"
echo JAVA_HOME=%JAVA_HOME%
rem Check Java
if not exist "%JAVA_HOME%" (
  if exist "%JAVA_INSTALLER%" (
    echo Install %JAVA_HOME% 
    %JAVA_INSTALLER% /s INSTALLDIR="%JAVA_HOME%"
    if exist "%JAVA_HOME%" (
      echo Java Installer %JAVA_INSTALLER% succeeded.
    ) else (      
      echo Java Installer %JAVA_INSTALLER% apparently failed.
    )
  ) else (
    echo Java Installer %JAVA_INSTALLER% does not exist.
  )
) else (
  echo JAVA_HOME %JAVA_HOME% exists
)
rem Part 3: Check the QuickStart Installer Files
rem check SOA12.2 QS
if exist "%JAVA_HOME%" (
  if not exist "%FMW_HOME%" (
    echo Quickstart Installer %QS_JAR% not installed yet.
    echo Let's try to install it in %FMW_HOME%
    if not exist %QS_EXTRACT_HOME% (
      echo Temp folder %QS_EXTRACT_HOME% does not exist, create it.
      mkdir %QS_EXTRACT_HOME%
    ) else (
      echo Temp folder %QS_EXTRACT_HOME% already exists.
    )
    echo Change to %QS_EXTRACT_HOME% for installation.
    cd %QS_EXTRACT_HOME%
    rem Check Quickstart is unzipped
    echo Check if QuickStart Installer is unzipped.
    rem Check QS_JAR
    if not exist "%QS_JAR%" (
      echo QuickStart Jar part 1 %QS_JAR% does not exist yet.
      if exist "%QS_ZIP%" (
        echo Unzip QuickStart Part 1 %QS_ZIP%
        "%JAVA_HOME%"\bin\jar.exe -xf %QS_ZIP% 
        if exist "%QS_JAR%" (
          echo QuickStart Jar part 1 %QS_JAR% now exists.
        ) else (
          echo QuickStart Jar part 1 %QS_JAR% still not exists.
        )
      ) else (
        echo QuickStart ZIP part 1 %QS_ZIP% does not exist.
      )
    ) else ( 
      echo QuickStart Jar part 1 %QS_JAR% exists.
    )
    rem Check QS_JAR2
    if exist "%QS_JAR%" (
      if not exist "%QS_JAR2%" (
        echo QuickStart Jar part 2 %QS_JAR2% does not exist yet.
        if exist "%QS_ZIP2%" (
          echo Unzip QuickStart Part 2 %QS_ZIP2%
          "%JAVA_HOME%"\bin\jar.exe -xf %QS_ZIP2% 
          if exist "%QS_JAR2%" (
            echo QuickStart Jar part 2 %QS_JAR2% now exists.
          ) else (
            echo QuickStart Jar part 2 %QS_JAR2% still not exists.
          )
        ) else (
          echo QuickStart ZIP part 2 %QS_ZIP2% does not exist.
        )
      ) else ( 
        echo QuickStart Jar part 2 %QS_JAR2% exists.
      )
    ) 
    rem Part 4: Install the QuickStart
    echo Install %FMW_HOME% 
    echo Expand Response File Template %CMD_LOC%\%QS_RSP_TPL% to %CMD_LOC%\%QS_RSP%
    powershell -Command "(Get-Content %CMD_LOC%\%QS_RSP_TPL%) -replace '\$\{ORACLE_HOME\}', '%FMW_HOME%' | Out-File -encoding ASCII %CMD_LOC%\%QS_RSP%"
    echo Silent install SOA QuickStart, using response file: %CMD_LOC%\%QS_RSP%
    "%JAVA_HOME%\bin\java.exe" -jar %QS_JAR% -silent -responseFile %CMD_LOC%\%QS_RSP% -nowait
    echo Change back to %CURRENT_DIR%.
    cd %CURRENT_DIR%
    if exist "%FMW_HOME%" (
      echo FMW_HOME %FMW_HOME% exists
      rem Part 5: update the JDeveloper User Home location.
      echo "et the JDeveloper user home settings
      if not exist %QS_USER_DIR% mkdir %QS_USER_DIR%
      echo set  JDEV_USER_DIR_SOA and JDEV_USER_HOME_SOA as  %QS_USER_DIR%
      setx -m JDEV_USER_DIR_SOA %QS_USER_DIR%
      setx -m JDEV_USER_HOME_SOA %QS_USER_DIR%
      echo copy %CMD_LOC%\jdev.boot naar "%FMW_HOME%\jdeveloper\jdev\bin"
      copy "%FMW_HOME%\jdeveloper\jdev\bin\jdev.boot" "%FMW_HOME%\jdeveloper\jdev\bin\jdev.boot.org" /Y
      copy %CMD_LOC%\jdev.boot "%FMW_HOME%\jdeveloper\jdev\bin" /Y
      echo copy %CMD_LOC%\ide.conf naar "%FMW_HOME%\jdeveloper\ide\bin"
      copy "%FMW_HOME%\jdeveloper\ide\bin\ide.conf" "%FMW_HOME%\jdeveloper\ide\bin\ide.conf.org" /Y
      copy %CMD_LOC%\ide.conf "%FMW_HOME%\jdeveloper\ide\bin" /Y
    ) else (
      echo Quickstart Installer %QS_JAR% apparently failed.  
    )
  ) else (
    echo Quickstart Installer %QS_JAR% already installed in %FMW_HOME%.
  )
) else (
  echo %JAVA_HOME% doesn't exist so can't install SOA Quick Start.
)
echo Done