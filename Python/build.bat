@echo off
setlocal enabledelayedexpansion

echo [1/4] Trying direct PATH pyinstaller...
pyinstaller --onefile ac.py
if !errorlevel! equ 0 goto success

echo.
echo [2/4] Trying via python module...
python -m PyInstaller --onefile ac.py
if !errorlevel! equ 0 goto success

echo.
echo [3/4] Trying via Windows Python launcher (py)...
py -m PyInstaller --onefile ac.py
if !errorlevel! equ 0 goto success

echo.
echo [4/4] Searching AppData local Scripts path...
set "LOCAL_PY=%LOCALAPPDATA%\Programs\Python"
if exist "%LOCAL_PY%" (
    for /d %%D in ("%LOCAL_PY%\Python*") do (
        if exist "%%D\Scripts\pyinstaller.exe" (
            echo Found pyinstaller in %%D\Scripts\
            "%%D\Scripts\pyinstaller.exe" --onefile ac.py
            if !errorlevel! equ 0 goto success
        )
    )
)

echo.
echo ==============================================
echo [ERROR] Build failed across all methods.
echo Make sure PyInstaller is installed: pip install pyinstaller
echo ==============================================
goto end

:success
echo.
echo ==============================================
echo [SUCCESS] AntiCheat build completed successfully!
echo Executable located in \dist\
echo ==============================================

:end
pause
endlocal