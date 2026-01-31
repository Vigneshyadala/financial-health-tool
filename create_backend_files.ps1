# Navigate to backend directory
cd Desktop\financial-health-tool\backend

# Create file_parser.py
@"
import pandas as pd
import PyPDF2
from io import BytesIO
from typing import Dict, Any

class FileParser:
    @staticmethod
    def parse_csv(file_content: bytes) -> pd.DataFrame:
        return pd.read_csv(BytesIO(file_content))
    
    @staticmethod
    def parse_xlsx(file_content: bytes) -> pd.DataFrame:
        return pd.read_excel(BytesIO(file_content))
    
    @staticmethod
    def parse_pdf(file_content: bytes) -> str:
        pdf_reader = PyPDF2.PdfReader(BytesIO(file_content))
        text = ""
        for page in pdf_reader.pages:
            text += page.extract_text()
        return text
    
    @staticmethod
    def extract_financial_data(df: pd.DataFrame) -> Dict[str, Any]:
        data = {
            "revenue_streams": [],
            "expenses": [],
            "total_revenue": 0.0,
            "total_expenses": 0.0,
            "net_profit": 0.0,
            "profit_margin": 0.0,
            "monthly_data": []
        }
        
        try:
            revenue_cols = [col for col in df.columns if 'revenue' in col.lower() or 'income' in col.lower() or 'sales' in col.lower()]
            expense_cols = [col for col in df.columns if 'expense' in col.lower() or 'cost' in col.lower()]
            
            if revenue_cols:
                data["total_revenue"] = df[revenue_cols].sum().sum()
                data["revenue_streams"] = df[revenue_cols].sum().to_dict()
            
            if expense_cols:
                data["total_expenses"] = df[expense_cols].sum().sum()
                data["expenses"] = df[expense_cols].sum().to_dict()
            
            data["net_profit"] = data["total_revenue"] - data["total_expenses"]
            
            if data["total_revenue"] > 0:
                data["profit_margin"] = (data["net_profit"] / data["total_revenue"]) * 100
            
            if 'month' in df.columns or 'Month' in df.columns:
                month_col = 'month' if 'month' in df.columns else 'Month'
                monthly_data = []
                
                for _, row in df.iterrows():
                    monthly_data.append({
                        "month": str(row[month_col]),
                        "revenue": float(row[revenue_cols[0]]) if revenue_cols else 0.0,
                        "expenses": float(row[expense_cols[0]]) if expense_cols else 0.0
                    })
                
                data["monthly_data"] = monthly_data
            
        except Exception as e:
            print(f"Error extracting financial data: {e}")
        
        return data
    
    @staticmethod
    def calculate_health_score(financial_data: Dict[str, Any]) -> tuple:
        score = 50
        
        profit_margin = financial_data.get("profit_margin", 0)
        if profit_margin > 20:
            score += 30
        elif profit_margin > 10:
            score += 20
        elif profit_margin > 0:
            score += 10
        elif profit_margin < -10:
            score -= 20
        
        revenue = financial_data.get("total_revenue", 0)
        if revenue > 1000000:
            score += 20
        elif revenue > 500000:
            score += 15
        elif revenue > 100000:
            score += 10
        elif revenue > 0:
            score += 5
        
        if len(financial_data.get("monthly_data", [])) > 0:
            score += 10
        
        score = max(0, min(100, score))
        
        if score >= 75:
            risk_level = "Low"
        elif score >= 50:
            risk_level = "Medium"
        elif score >= 25:
            risk_level = "High"
        else:
            risk_level = "Critical"
        
        return score, risk_level
"@ | Out-File -FilePath "app\utils\file_parser.py" -Encoding UTF8

Write-Host "Created file_parser.py"