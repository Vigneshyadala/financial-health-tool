from fastapi import APIRouter, UploadFile, File, Form, Depends, HTTPException
from sqlalchemy.orm import Session
from app.models.database import get_db
from app.models.assessment import FinancialAssessment
from app.utils.file_parser import FileParser
from app.services.ai_analysis import AIAnalysisService
from typing import List
import json

router = APIRouter(prefix="/api/assessments", tags=["assessments"])

@router.post("/upload")
async def upload_financial_data(
    file: UploadFile = File(...),
    company_name: str = Form(...),
    industry: str = Form(...),
    db: Session = Depends(get_db)
):
    """Upload and analyze financial data file"""
    
    try:
        # Read file content
        content = await file.read()
        file_type = file.filename.split('.')[-1].lower()
        
        # Parse file based on type
        parser = FileParser()
        financial_data = {}
        
        if file_type == 'csv':
            df = parser.parse_csv(content)
            financial_data = parser.extract_financial_data(df)
        elif file_type in ['xlsx', 'xls']:
            df = parser.parse_xlsx(content)
            financial_data = parser.extract_financial_data(df)
        elif file_type == 'pdf':
            text = parser.parse_pdf(content)
            financial_data = {
                "total_revenue": 0,
                "total_expenses": 0,
                "net_profit": 0,
                "profit_margin": 0,
                "pdf_text": text[:500]  # First 500 chars
            }
        else:
            raise HTTPException(status_code=400, detail="Unsupported file type")
        
        # Calculate health score
        health_score, risk_level = parser.calculate_health_score(financial_data)
        financial_data["health_score"] = health_score
        financial_data["risk_level"] = risk_level
        
        # AI Analysis
        ai_service = AIAnalysisService()
        ai_analysis = ai_service.analyze_financial_health(financial_data, company_name, industry)
        
        # Save to database
        assessment = FinancialAssessment(
            company_name=company_name,
            industry=industry,
            total_revenue=float(financial_data.get("total_revenue", 0)),
            total_expenses=float(financial_data.get("total_expenses", 0)),
            net_profit=float(financial_data.get("net_profit", 0)),
            profit_margin=float(financial_data.get("profit_margin", 0)),
            health_score=float(health_score),
            risk_level=risk_level,
            ai_insights=ai_analysis.get("insights", []),
            recommendations=ai_analysis.get("recommendations", []),
            risk_factors=ai_analysis.get("risks", []),
            file_name=file.filename,
            file_type=file_type
        )
        
        db.add(assessment)
        db.commit()
        db.refresh(assessment)
        
        # Prepare response - Convert all numpy types to Python types
        response = {
            "id": assessment.id,
            "company_name": company_name,
            "industry": industry,
            "financial_metrics": {
                "total_revenue": float(financial_data.get("total_revenue", 0)),
                "total_expenses": float(financial_data.get("total_expenses", 0)),
                "net_profit": float(financial_data.get("net_profit", 0)),
                "profit_margin": float(financial_data.get("profit_margin", 0))
            },
            "health_score": float(health_score),
            "risk_level": risk_level,
            "monthly_data": [
                {
                    "month": str(item.get("month", "")),
                    "revenue": float(item.get("revenue", 0)),
                    "expenses": float(item.get("expenses", 0))
                }
                for item in financial_data.get("monthly_data", [])
            ],
            "ai_analysis": ai_analysis,
            "file_info": {
                "name": file.filename,
                "type": file_type
            }
        }
        
        return response
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error processing file: {str(e)}")


@router.get("/")
async def get_assessments(db: Session = Depends(get_db)):
    """Get all financial assessments"""
    assessments = db.query(FinancialAssessment).order_by(FinancialAssessment.created_at.desc()).all()
    return assessments


@router.get("/{assessment_id}")
async def get_assessment(assessment_id: int, db: Session = Depends(get_db)):
    """Get specific assessment by ID"""
    assessment = db.query(FinancialAssessment).filter(FinancialAssessment.id == assessment_id).first()
    
    if not assessment:
        raise HTTPException(status_code=404, detail="Assessment not found")
    
    return {
        "id": assessment.id,
        "company_name": assessment.company_name,
        "industry": assessment.industry,
        "financial_metrics": {
            "total_revenue": float(assessment.total_revenue),
            "total_expenses": float(assessment.total_expenses),
            "net_profit": float(assessment.net_profit),
            "profit_margin": float(assessment.profit_margin)
        },
        "health_score": float(assessment.health_score),
        "risk_level": assessment.risk_level,
        "ai_analysis": {
            "insights": assessment.ai_insights,
            "recommendations": assessment.recommendations,
            "risks": assessment.risk_factors
        },
        "file_info": {
            "name": assessment.file_name,
            "type": assessment.file_type
        },
        "created_at": str(assessment.created_at)
    }