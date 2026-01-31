# 📂 FILE MAPPING GUIDE - Where to Save Each File

## 🎯 IMPORTANT: Read This First!

Each file downloaded above needs to be saved in a specific location. Follow this guide exactly!

---

## 📁 STEP 1: Create Folder Structure

First, open Command Prompt and run:

```bash
cd Desktop
mkdir financial-health-tool
cd financial-health-tool
mkdir backend\app\models backend\app\routes backend\app\services backend\app\utils
mkdir frontend\src\components frontend\src\services
```

---

## 📋 STEP 2: Save Files in Correct Locations

### BACKEND FILES (Total: 10 files)

| File Downloaded | Save As | Location |
|----------------|---------|----------|
| requirements.txt | requirements.txt | `Desktop\financial-health-tool\backend\` |
| env.example.txt | .env.example | `Desktop\financial-health-tool\backend\` |
| config.py | config.py | `Desktop\financial-health-tool\backend\app\` |
| assessment.py | assessment.py | `Desktop\financial-health-tool\backend\app\models\` |
| database.py | database.py | `Desktop\financial-health-tool\backend\app\models\` |
| file_parser.py | file_parser.py | `Desktop\financial-health-tool\backend\app\utils\` |
| ai_analysis.py | ai_analysis.py | `Desktop\financial-health-tool\backend\app\services\` |
| assessments.py | assessments.py | `Desktop\financial-health-tool\backend\app\routes\` |
| main.py | main.py | `Desktop\financial-health-tool\backend\` |
| sample_data.csv | sample_data.csv | `Desktop\financial-health-tool\backend\` |

### FRONTEND FILES (Created separately - coming next)

| File | Location |
|------|----------|
| package.json | `Desktop\financial-health-tool\frontend\` |
| index.html | `Desktop\financial-health-tool\frontend\` |
| vite.config.js | `Desktop\financial-health-tool\frontend\` |
| tailwind.config.js | `Desktop\financial-health-tool\frontend\` |
| postcss.config.js | `Desktop\financial-health-tool\frontend\` |
| src/index.css | `Desktop\financial-health-tool\frontend\src\` |
| src/App.jsx | `Desktop\financial-health-tool\frontend\src\` |
| src/main.jsx | `Desktop\financial-health-tool\frontend\src\` |
| src/services/api.js | `Desktop\financial-health-tool\frontend\src\services\` |

---

## 🔧 HOW TO SAVE FILES FROM DOWNLOADS

### Method 1: Using Notepad (Recommended for Windows)

For each file:

1. **Download the file** (click download button above)
2. **Open the downloaded file** with Notepad
3. **Copy ALL the content** (Ctrl+A, then Ctrl+C)
4. **Open Notepad** (new window)
5. **Paste** (Ctrl+V)
6. **Save As**:
   - Click File → Save As
   - Navigate to the correct folder (see table above)
   - **File name**: Use exact name from table
   - **Save as type**: Select "All Files (*.*)"
   - Click Save

### Method 2: Direct Copy (If files download correctly)

1. Files will download to your `Downloads` folder
2. Copy each file to the correct location per the table above

---

## ✅ VERIFICATION CHECKLIST

After saving all files, your structure should look like this:

```
Desktop\financial-health-tool\
├── backend\
│   ├── app\
│   │   ├── models\
│   │   │   ├── assessment.py ✓
│   │   │   └── database.py ✓
│   │   ├── routes\
│   │   │   └── assessments.py ✓
│   │   ├── services\
│   │   │   └── ai_analysis.py ✓
│   │   ├── utils\
│   │   │   └── file_parser.py ✓
│   │   └── config.py ✓
│   ├── main.py ✓
│   ├── requirements.txt ✓
│   ├── .env.example ✓
│   └── sample_data.csv ✓
│
└── frontend\
    ├── src\
    │   ├── components\
    │   ├── services\
    │   │   └── api.js ✓
    │   ├── App.jsx ✓
    │   ├── main.jsx ✓
    │   └── index.css ✓
    ├── index.html ✓
    ├── package.json ✓
    ├── vite.config.js ✓
    ├── tailwind.config.js ✓
    └── postcss.config.js ✓
```

---

## 🚨 IMPORTANT NOTES

1. **File Extensions**: Make sure to save with correct extensions (.py, .js, .jsx, .json, .csv, .css, .html)
2. **No .txt**: Don't add .txt to any filename
3. **.env.example**: This file MUST start with a dot (.)
4. **Exact Names**: Use exact file names from the table

---

## 🆘 TROUBLESHOOTING

**Problem**: Can't see file extensions
**Solution**: 
- Open any folder
- Click "View" tab
- Check "File name extensions"

**Problem**: Can't create `.env.example` (starts with dot)
**Solution**:
- Open Command Prompt
- Navigate to backend folder: `cd Desktop\financial-health-tool\backend`
- Run: `copy nul .env.example`
- Then open with Notepad and paste content

---

## ⏭️ WHAT'S NEXT?

After saving all backend files:
1. I'll provide the remaining frontend files
2. Then we'll push to GitHub
3. Deploy to Railway and Vercel
4. Submit to hackathon!

---

**Save this document for reference!**
