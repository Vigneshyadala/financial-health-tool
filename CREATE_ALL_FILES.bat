@echo off
setlocal enabledelayedexpansion
title Creating ALL Project Files
color 0A

echo ============================================================
echo    CREATING ALL PROJECT FILES
echo    Financial Health Assessment Tool
echo ============================================================
echo.

cd C:\Users\Lenovo\Desktop\financial-health-tool

echo Cleaning up old files...
if exist backend_new rmdir /S /Q backend_new
if exist frontend_new rmdir /S /Q frontend_new
if exist financial-health-tool rmdir /S /Q financial-health-tool

echo.
echo Creating file structure...
if not exist backend\app\models mkdir backend\app\models
if not exist backend\app\routes mkdir backend\app\routes
if not exist backend\app\services mkdir backend\app\services
if not exist backend\app\utils mkdir backend\app\utils
if not exist frontend\src\components mkdir frontend\src\components
if not exist frontend\src\services mkdir frontend\src\services

echo.
echo ============================================================
echo CREATING BACKEND FILES...
echo ============================================================
echo.

REM Create requirements.txt
echo Creating requirements.txt...
(
echo fastapi==0.104.1
echo uvicorn==0.24.0
echo python-multipart==0.0.6
echo anthropic==0.7.7
echo pandas==2.1.3
echo openpyxl==3.1.2
echo PyPDF2==3.0.1
echo sqlalchemy==2.0.23
echo python-dotenv==1.0.0
echo pydantic==2.5.0
echo pydantic-settings==2.1.0
) > backend\requirements.txt

REM Create .env.example
echo Creating .env.example...
(
echo ANTHROPIC_API_KEY=your_anthropic_api_key_here
echo DATABASE_URL=sqlite:///./financial_health.db
echo ENVIRONMENT=development
) > backend\.env.example

REM Create .env
echo Creating .env...
copy backend\.env.example backend\.env > nul

REM Create sample_data.csv
echo Creating sample_data.csv...
(
echo Month,Revenue,Operating_Expenses,Marketing_Expenses,Salaries,Total_Expenses
echo January,450000,80000,25000,120000,225000
echo February,480000,82000,28000,120000,230000
echo March,520000,85000,30000,125000,240000
echo April,495000,83000,27000,122000,232000
echo May,530000,88000,32000,125000,245000
echo June,560000,90000,35000,128000,253000
echo July,575000,92000,33000,130000,255000
echo August,590000,95000,36000,130000,261000
echo September,610000,97000,38000,132000,267000
echo October,625000,98000,40000,135000,273000
echo November,640000,100000,42000,135000,277000
echo December,680000,105000,45000,140000,290000
) > backend\sample_data.csv

REM Create __init__.py files
echo Creating __init__.py files...
echo. > backend\app\__init__.py
echo. > backend\app\models\__init__.py
echo. > backend\app\routes\__init__.py
echo. > backend\app\services\__init__.py
echo. > backend\app\utils\__init__.py

echo.
echo ✓ Basic backend files created
echo.
echo ============================================================
echo IMPORTANT: Python files need to be created with notepad
echo ============================================================
echo.
echo Due to Windows command line limitations, the following
echo Python files MUST be created using notepad:
echo.
echo 1. backend\app\config.py
echo 2. backend\app\models\assessment.py
echo 3. backend\app\models\database.py
echo 4. backend\app\utils\file_parser.py
echo 5. backend\app\services\ai_analysis.py
echo 6. backend\app\routes\assessments.py
echo 7. backend\main.py
echo.
echo I will open notepad for each file.
echo COPY the content from Claude and PASTE into each file.
echo.
pause

REM Open notepad for each Python file
echo.
echo Opening notepad for config.py...
echo Copy the config.py content from Claude conversation and paste it
start /wait notepad backend\app\config.py

echo.
echo Opening notepad for assessment.py...
echo Copy the assessment.py content from Claude conversation and paste it
start /wait notepad backend\app\models\assessment.py

echo.
echo Opening notepad for database.py...
echo Copy the database.py content from Claude conversation and paste it
start /wait notepad backend\app\models\database.py

echo.
echo Opening notepad for file_parser.py...
echo Copy the file_parser.py content from Claude conversation and paste it
start /wait notepad backend\app\utils\file_parser.py

echo.
echo Opening notepad for ai_analysis.py...
echo Copy the ai_analysis.py content from Claude conversation and paste it
start /wait notepad backend\app\services\ai_analysis.py

echo.
echo Opening notepad for assessments.py...
echo Copy the assessments.py content from Claude conversation and paste it
start /wait notepad backend\app\routes\assessments.py

echo.
echo Opening notepad for main.py...
echo Copy the main.py content from Claude conversation and paste it
start /wait notepad backend\main.py

echo.
echo ============================================================
echo CREATING FRONTEND FILES...
echo ============================================================
echo.

REM Create package.json
echo Creating package.json...
(
echo {
echo   "name": "financial-health-frontend",
echo   "private": true,
echo   "version": "1.0.0",
echo   "type": "module",
echo   "scripts": {
echo     "dev": "vite",
echo     "build": "vite build",
echo     "preview": "vite preview"
echo   },
echo   "dependencies": {
echo     "react": "^18.2.0",
echo     "react-dom": "^18.2.0",
echo     "axios": "^1.6.2",
echo     "recharts": "^2.10.3"
echo   },
echo   "devDependencies": {
echo     "@types/react": "^18.2.43",
echo     "@types/react-dom": "^18.2.17",
echo     "@vitejs/plugin-react": "^4.2.1",
echo     "autoprefixer": "^10.4.16",
echo     "postcss": "^8.4.32",
echo     "tailwindcss": "^3.3.6",
echo     "vite": "^5.0.8"
echo   }
echo }
) > frontend\package.json

echo.
echo Now opening notepad for frontend files...
echo Copy each file content from Claude conversation
echo.
pause

REM Frontend files with notepad
echo Opening notepad for index.html...
start /wait notepad frontend\index.html

echo Opening notepad for vite.config.js...
start /wait notepad frontend\vite.config.js

echo Opening notepad for tailwind.config.js...
start /wait notepad frontend\tailwind.config.js

echo Opening notepad for postcss.config.js...
start /wait notepad frontend\postcss.config.js

echo Opening notepad for src\index.css...
start /wait notepad frontend\src\index.css

echo Opening notepad for src\main.jsx...
start /wait notepad frontend\src\main.jsx

echo Opening notepad for src\services\api.js...
start /wait notepad frontend\src\services\api.js

echo Opening notepad for src\App.jsx (LARGE FILE)...
start /wait notepad frontend\src\App.jsx

echo.
echo ============================================================
echo ROOT FILES
echo ============================================================
echo.

REM .gitignore
echo Creating .gitignore...
(
echo # Python
echo __pycache__/
echo *.py[cod]
echo *.so
echo .Python
echo venv/
echo env/
echo *.egg-info/
echo *.db
echo *.sqlite
echo.
echo # Node
echo node_modules/
echo npm-debug.log*
echo frontend/dist/
echo.
echo # Environment
echo .env
echo .env.local
echo.
echo # IDEs
echo .vscode/
echo .idea/
echo .DS_Store
) > .gitignore

REM README.md
echo Creating README.md...
(
echo # Financial Health Assessment Tool
echo.
echo AI-powered Financial Health Assessment Platform for SMEs
echo.
echo ## Career Carnival 2026 - HCL ^& GUVI
echo.
echo ### Author
echo Vignesh Yadala - vignesh.yadala@gmail.com
echo.
echo ### Features
echo - Multi-format file upload ^(CSV, XLSX, PDF^)
echo - AI-powered analysis with Claude
echo - Financial health scoring
echo - Risk assessment
echo - Interactive visualizations
echo.
echo ### Tech Stack
echo - Backend: FastAPI + Claude AI
echo - Frontend: React.js + Tailwind CSS
echo - Database: SQLite/PostgreSQL
) > README.md

echo.
echo ============================================================
echo    ALL FILES CREATED!
echo ============================================================
echo.
echo Your project structure is now complete at:
echo C:\Users\Lenovo\Desktop\financial-health-tool
echo.
echo NEXT STEPS:
echo.
echo 1. Install Node.js from https://nodejs.org (if not done)
echo 2. Restart Command Prompt
echo 3. Install backend dependencies:
echo    cd backend
echo    pip install -r requirements.txt
echo.
echo 4. Install frontend dependencies:
echo    cd frontend
echo    npm install
echo.
echo 5. Run backend:
echo    cd backend
echo    python main.py
echo.
echo 6. Run frontend (new window):
echo    cd frontend
echo    npm run dev
echo.
echo 7. Open http://localhost:3000 in browser
echo.
echo ============================================================
echo.
pause
