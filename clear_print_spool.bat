@echo off

setlocal

SET /P AREYOUSURE=Are you sure you want to clear the whole print spool? (Y/N)?
SET printers_path="%systemroot%\System32\Spool\Printers\*.*"
SET exit_message=All print queues have been cleared. Press any key to exit :)
IF /I "%AREYOUSURE%" NEQ "Y" GOTO END
timeout /t 1 /nobreak > nul

:: Stop the print spooler service
echo Step 1: Stopping Print Spooler
echo ----------------------------------
net stop spooler
timeout /t 1 /nobreak > nul
echo Print Spooler stopped
timeout /t 1 /nobreak > nul
echo.

:: Erase all files in the folder
echo Step 2: Erasing queued print files
echo ----------------------------------
del /Q /F /S %printers_path%
timeout /t 1 /nobreak > nul
echo.
echo Print files deleted
timeout /t 1 /nobreak > nul
echo.

:: Restart the print spooler service
echo Step 3: Restarting Print Spooler
echo ----------------------------------
net start spooler
timeout /t 1 /nobreak > nul
echo Print Spooler restarted
timeout /t 1 /nobreak > nul
echo.

pause>nul|set/p = %exit_message%

endlocal
