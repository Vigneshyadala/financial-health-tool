from sqlalchemy import Column, Integer, String, Float, DateTime, Text, JSON
from sqlalchemy.ext.declarative import declarative_base
from datetime import datetime

Base = declarative_base()

class FinancialAssessment(Base):
    __tablename__ = "financial_assessments"
    
    id = Column(Integer, primary_key=True, index=True)
    company_name = Column(String, index=True)
    industry = Column(String)
    assessment_date = Column(DateTime, default=datetime.utcnow)
    
    # Financial metrics
    total_revenue = Column(Float)
    total_expenses = Column(Float)
    net_profit = Column(Float)
    profit_margin = Column(Float)
    
    # Health score
    health_score = Column(Float)
    risk_level = Column(String)
    
    # AI Analysis
    ai_insights = Column(JSON)
    recommendations = Column(JSON)
    risk_factors = Column(JSON)
    
    # File info
    file_name = Column(String)
    file_type = Column(String)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    updated_at = Column(DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)