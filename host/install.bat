@ECHO OFF

SET NAME=com.clear_code.ieview_we_host

ECHO Installing %NAME%...

SET INSTALL_DIR=%LocalAppData%\%NAME%
MD "%INSTALL_DIR%"
IF %PROCESSOR_ARCHITECTURE% == AMD64 (
  ECHO Copying binary for AMD64...
  COPY amd64\*.exe "%INSTALL_DIR%\"
) ELSE (
  ECHO Copying binary for x86...
  COPY 386\*.exe "%INSTALL_DIR%\"
)
COPY *.json "%INSTALL_DIR%\"
COPY *.bat "%INSTALL_DIR%\"

ECHO Registering...
FOR %%f IN ("%INSTALL_DIR%") DO SET EXPANDED_PATH=%%~sf
REG ADD "HKCU\SOFTWARE\Mozilla\NativeMessagingHosts\%NAME%" /ve /t REG_SZ /d "%EXPANDED_PATH%\%NAME%.json" /f

ECHO Done.
PAUSE
