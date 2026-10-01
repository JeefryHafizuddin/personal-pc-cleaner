@echo off
title JEEFRY PC Cleaner
color 0A
mode con: cols=80 lines=45

:: ---------- Admin check ----------
net session >nul 2>&1
if %errorlevel% neq 0 goto :needadmin
goto :menu

:needadmin
cls
echo.
echo   This tool needs ADMINISTRATOR rights.
echo   Right-click the file and choose "Run as administrator".
echo.
pause
exit /b

:menu
cls
echo.
echo                 ##################
echo               ######################
echo                       ########
echo                       ########
echo                       ########
echo                       ########
echo                       ########
echo                       ########
echo                       ########
echo                       ########
echo                       ########
echo         ###           ########
echo        #####         #########
echo       #######       ##########
echo       #########    ###########
echo        #######################
echo          ###################
echo             ##############
echo                 ######
echo.
echo   ==========================================================
echo                  J E E F R Y   PC   C L E A N E R
echo   ==========================================================
echo.
echo      [1]  Clean Temporary Storage
echo      [2]  Windows Disk Cleanup (automatic)
echo      [3]  Flush DNS and Reset Network Cache
echo      [4]  Enable Performance Mode
echo      [5]  Deep Junk Cleanup (browsers, logs, updates, bin)
echo      [6]  Repair System Files (SFC + DISM)
echo.
echo      [0]  Exit
echo.
echo   ----------------------------------------------------------
echo                    Made by JEEFRY
echo   ----------------------------------------------------------
echo.
set "choice="
set /p "choice=   Choose an option (0-6): "

if "%choice%"=="1" goto :opt1
if "%choice%"=="2" goto :opt2
if "%choice%"=="3" goto :opt3
if "%choice%"=="4" goto :opt4
if "%choice%"=="5" goto :opt5
if "%choice%"=="6" goto :opt6
if "%choice%"=="0" exit /b
echo.
echo   Invalid choice. Pick a number from 0 to 6.
timeout /t 2 >nul
goto :menu

:: ---------- 1: Temp files ----------
:opt1
cls
echo.
echo   [1] Cleaning temporary storage...
echo.
echo   - User temp folder
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%D in ("%TEMP%\*") do rd /s /q "%%D" >nul 2>&1
echo   - Local app temp folder
del /f /s /q "%LocalAppData%\Temp\*" >nul 2>&1
for /d %%D in ("%LocalAppData%\Temp\*") do rd /s /q "%%D" >nul 2>&1
echo   - Windows temp folder
del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1
for /d %%D in ("%SystemRoot%\Temp\*") do rd /s /q "%%D" >nul 2>&1
echo   - Prefetch cache
del /f /s /q "%SystemRoot%\Prefetch\*" >nul 2>&1
echo   - Recent file list
del /f /s /q "%AppData%\Microsoft\Windows\Recent\*" >nul 2>&1
echo.
echo   Done. Temporary storage cleaned.
echo.
pause
goto :menu

:: ---------- 2: Disk Cleanup ----------
:opt2
cls
echo.
echo   [2] Running Windows Disk Cleanup with all categories selected...
echo       This can take a few minutes. Please wait.
echo.
for /f "tokens=*" %%K in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches" 2^>nul') do reg add "%%K" /v StateFlags0099 /t REG_DWORD /d 2 /f >nul 2>&1
start /wait cleanmgr /sagerun:99
echo.
echo   Done. Disk Cleanup finished.
echo.
pause
goto :menu

:: ---------- 3: DNS / network ----------
:opt3
cls
echo.
echo   [3] Flushing DNS and resetting network cache...
echo.
ipconfig /flushdns
ipconfig /registerdns >nul 2>&1
arp -d * >nul 2>&1
nbtstat -R >nul 2>&1
netsh winsock reset >nul 2>&1
echo.
echo   Done. DNS flushed. Restart the PC later to fully apply the Winsock reset.
echo.
pause
goto :menu

:: ---------- 4: Performance mode ----------
:opt4
cls
echo.
echo   [4] Enabling performance mode...
echo.
echo   - Setting power plan
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
if %errorlevel% neq 0 powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
echo   - Turning off transparency effects
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul 2>&1
echo   - Setting visual effects to best performance
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
echo   - Turning off Game DVR background recording
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
echo.
echo   Done. Performance mode enabled. Sign out and back in for all visual changes.
echo.
pause
goto :menu

:: ---------- 5: Deep junk cleanup ----------
:opt5
cls
echo.
echo   [5] Deep junk cleanup...
echo.
echo   - Chrome cache
del /f /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache\*" >nul 2>&1
del /f /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache\*" >nul 2>&1
echo   - Edge cache
del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache\*" >nul 2>&1
del /f /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Code Cache\*" >nul 2>&1
echo   - Firefox cache
for /d %%P in ("%LocalAppData%\Mozilla\Firefox\Profiles\*") do del /f /s /q "%%P\cache2\*" >nul 2>&1
echo   - Thumbnail and icon cache
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /q "%LocalAppData%\IconCache.db" >nul 2>&1
echo   - Windows error reports and logs
del /f /s /q "%ProgramData%\Microsoft\Windows\WER\ReportQueue\*" >nul 2>&1
del /f /s /q "%ProgramData%\Microsoft\Windows\WER\ReportArchive\*" >nul 2>&1
del /f /s /q "%SystemRoot%\Logs\CBS\*.log" >nul 2>&1
del /f /s /q "%SystemRoot%\Minidump\*" >nul 2>&1
echo   - Windows Update download cache
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
net start bits >nul 2>&1
net start wuauserv >nul 2>&1
echo   - Emptying Recycle Bin
rd /s /q "%SystemDrive%\$Recycle.Bin" >nul 2>&1
echo.
echo   Done. Junk cleaned. Close your browsers first next time for best results.
echo.
pause
goto :menu

:: ---------- 6: System repair ----------
:opt6
cls
echo.
echo   [6] Repairing system files...
echo       This can take 10 to 30 minutes. Do not close this window.
echo.
echo   - DISM health restore
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo   - System File Checker
sfc /scannow
echo.
echo   Done. Restart the PC if repairs were made.
echo.
pause
goto :menu
