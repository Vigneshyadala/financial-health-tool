import pandas as pd
import PyPDF2
from io import BytesIO
from typing import Dict, Any

class FileParser:
    @staticmethod
    def parse_csv(file_content: bytes) -> pd.DataFrame:
        """Parse CSV file content"""
        return pd.read_csv(BytesIO(file_content))
    
    @staticmethod
    def parse_xlsx(file_content: bytes) -> pd.DataFrame:
        """Parse Excel file content"""
        return pd.read_excel(BytesIO(file_content))
    
    @staticmethod
    def parse_pdf(file_content: bytes) -> str:
        """Extract text from PDF"""
        pdf_reader = PyPDF2.PdfReader(BytesIO(file_content))
        text = ""
        for page in pdf_reader.pages:
            text += page.extract_text()
        return text
    
    @staticmethod
    def extract_financial_data(df: pd.DataFrame) -> Dict[str, Any]:
        """Extract financial metrics from DataFrame"""
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
            # Try to identify revenue and expense columns
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
            
            # Extract monthly data if available
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
        """Calculate financial health score (0-100) and risk level"""
        score = 50  # Base score
        
        # Profit margin contribution (0-30 points)
        profit_margin = financial_data.get("profit_margin", 0)
        if profit_margin > 20:
            score += 30
        elif profit_margin > 10:
            score += 20
        elif profit_margin > 0:
            score += 10
        elif profit_margin < -10:
            score -= 20
        
        # Revenue scale contribution (0-20 points)
        revenue = financial_data.get("total_revenue", 0)
        if revenue > 1000000:
            score += 20
        elif revenue > 500000:
            score += 15
        elif revenue > 100000:
            score += 10
        elif revenue > 0:
            score += 5
        
        # Growth trend (0-20 points) - simplified
        if len(financial_data.get("monthly_data", [])) > 0:
            score += 10
        
        # Cap score between 0-100
        score = max(0, min(100, score))
        
        # Determine risk level
        if score >= 75:
            risk_level = "Low"
        elif score >= 50:
            risk_level = "Medium"
        elif score >= 25:
            risk_level = "High"
        else:
            risk_level = "Critical"
        
        return score, risk_level
