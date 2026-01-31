@echo off
title Financial Health Assessment Tool - Complete Setup
color 0A

echo ============================================================
echo    Financial Health Assessment Tool
echo    Complete Installation and Testing
echo    Career Carnival 2026 - HCL ^& GUVI
echo ============================================================
echo.

REM Navigate to project directory
cd C:\Users\Lenovo\Desktop\financial-health-tool

echo [STEP 1] Creating missing files...
echo.

REM Create App.jsx in frontend
echo Creating App.jsx...
REM Note: This needs to be copied manually from the artifact

REM Create __init__.py files for Python packages
echo. > backend\app\__init__.py
echo. > backend\app\models\__init__.py
echo. > backend\app\routes\__init__.py
echo. > backend\app\services\__init__.py
echo. > backend\app\utils\__init__.py
echo Created __init__.py files

REM Create .env file from .env.example
echo.
echo [STEP 2] Creating .env file...
cd backend
if not exist .env (
    copy .env.example .env
    echo .env file created! You can add your Anthropic API key later.
    echo Note: The app works WITHOUT an API key using smart fallback logic!
) else (
    echo .env file already exists
)
echo.

echo [STEP 3] Installing Backend Dependencies...
echo This may take a few minutes...
echo.
pip install -r requirements.txt
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Failed to install backend dependencies!
    echo Make sure Python and pip are installed.
    pause
    exit /b 1
)
echo.
echo ✓ Backend dependencies installed successfully!
echo.

echo [STEP 4] Installing Frontend Dependencies...
echo This may take a few minutes...
echo.
cd ..\frontend
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Failed to install frontend dependencies!
    echo Make sure Node.js and npm are installed.
    pause
    exit /b 1
)
echo.
echo ✓ Frontend dependencies installed successfully!
echo.

echo ============================================================
echo    Installation Complete!
echo ============================================================
echo.
echo Your Financial Health Assessment Tool is now ready!
echo.
echo TO RUN THE APPLICATION:
echo.
echo 1. Start Backend (Terminal 1):
echo    cd backend
echo    python main.py
echo    Backend will run at: http://localhost:8000
echo    API Docs: http://localhost:8000/docs
echo.
echo 2. Start Frontend (Terminal 2):
echo    cd frontend  
echo    npm run dev
echo    Frontend will run at: http://localhost:3000
echo.
echo 3. Test the app:
echo    - Open http://localhost:3000 in your browser
echo    - Upload the sample file: backend\sample_data.csv
echo    - Company: "ABC Retail Company"
echo    - Industry: "Retail"
echo    - Click "Analyze Financial Health"
echo.
echo TROUBLESHOOTING:
echo - If backend fails: Check Python version (needs 3.8+)
echo - If frontend fails: Check Node version (needs 14+)
echo - Port already in use: Stop other services or change ports
echo.
echo ============================================================
echo.
echo Press any key to open TWO command prompts to run the app...
pause > nul

REM Open two new command prompts - one for backend, one for frontend
start "Backend Server" cmd /k "cd C:\Users\Lenovo\Desktop\financial-health-tool\backend && echo Starting Backend... && python main.py"
timeout /t 3 /nobreak > nul
start "Frontend Dev Server" cmd /k "cd C:\Users\Lenovo\Desktop\financial-health-tool\frontend && echo Starting Frontend... && npm run dev"

echo.
echo ✓ Backend and Frontend servers are starting...
echo ✓ Wait 10-15 seconds for both servers to start
echo ✓ Then open: http://localhost:3000
echo.
echo Press any key to exit this window...
pause > nul
