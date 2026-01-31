@echo off
echo ========================================
echo Financial Health Assessment Tool Setup
echo Career Carnival 2026 - Complete Setup
echo ========================================
echo.

cd C:\Users\Lenovo\Desktop\financial-health-tool

REM Create .gitignore
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

REM Create README.md
echo Creating README.md...
(
echo # Financial Health Assessment Tool
echo.
echo AI-powered Financial Health Assessment Platform for SMEs - Career Carnival 2026
echo.
echo ## Features
echo - Multi-format file upload ^(CSV, XLSX, PDF^)
echo - AI-powered analysis with Claude
echo - Financial health scoring
echo - Risk assessment
echo - Cost optimization recommendations
echo - Interactive visualizations
echo.
echo ## Tech Stack
echo - Backend: FastAPI + Claude AI
echo - Frontend: React.js + Tailwind CSS  
echo - Database: SQLite/PostgreSQL
echo.
echo ## Author
echo Vignesh Yadala - vignesh.yadala@gmail.com
echo.
echo ## Career Carnival 2026 - HCL ^& GUVI
) > README.md

REM Create __init__.py files
echo Creating __init__.py files...
echo. > backend\app\__init__.py
echo. > backend\app\models\__init__.py
echo. > backend\app\routes\__init__.py
echo. > backend\app\services\__init__.py
echo. > backend\app\utils\__init__.py

echo.
echo ========================================
echo SUCCESS! All files created!
echo ========================================
echo.
echo Your project structure is now complete!
echo.
echo NEXT STEPS:
echo 1. Install Python dependencies: cd backend ^&^& pip install -r requirements.txt
echo 2. Install Node dependencies: cd frontend ^&^& npm install
echo 3. Run backend: cd backend ^&^& python main.py
echo 4. Run frontend: cd frontend ^&^& npm run dev
echo.
echo Press any key to exit...
pause > nul
