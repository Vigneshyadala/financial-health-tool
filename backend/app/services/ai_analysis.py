from app.config import settings
from typing import Dict, Any, List
import json

class AIAnalysisService:
    def __init__(self):
        self.client = None  # Using rule-based analysis without AI

    def analyze_financial_health(self, financial_data: Dict[str, Any], company_name: str, industry: str) -> Dict[str, Any]:
        """Generate financial health analysis using rule-based logic"""
        return self._generate_fallback_analysis(financial_data, company_name, industry)

    def _generate_fallback_analysis(self, financial_data: Dict[str, Any], company_name: str, industry: str) -> Dict[str, Any]:
        """Generate rule-based analysis without AI dependency"""

        profit_margin = financial_data.get('profit_margin', 0)
        health_score = financial_data.get('health_score', 0)
        risk_level = financial_data.get('risk_level', 'Unknown')

        insights = []
        risks = []
        recommendations = []
        cost_optimization = []
        financial_products = []

        # Generate insights
        if profit_margin > 15:
            insights.append(f"{company_name} demonstrates strong profitability with a {profit_margin:.1f}% profit margin")
        elif profit_margin > 0:
            insights.append(f"{company_name} is profitable but has room for margin improvement (current: {profit_margin:.1f}%)")
        else:
            insights.append(f"{company_name} is currently operating at a loss with a {profit_margin:.1f}% margin")

        insights.append(f"The overall financial health score of {health_score:.1f}/100 indicates {risk_level.lower()} risk level")
        insights.append(f"Industry: {industry} sector performance should be benchmarked against competitors")

        revenue = financial_data.get('total_revenue', 0)
        if revenue > 1000000:
            insights.append("Strong revenue base provides good foundation for growth and investment")
        else:
            insights.append("Focus on revenue growth strategies to improve financial stability")

        # Generate risk factors
        if profit_margin < 5:
            risks.append({
                "factor": "Low Profit Margins",
                "severity": "High",
                "description": "Profit margins below 5% indicate pricing pressure or high costs"
            })

        if risk_level in ["High", "Critical"]:
            risks.append({
                "factor": "Overall Financial Health",
                "severity": "High",
                "description": f"{risk_level} risk level requires immediate attention and corrective action"
            })

        expense_ratio = (financial_data.get('total_expenses', 0) / revenue * 100) if revenue > 0 else 0
        if expense_ratio > 85:
            risks.append({
                "factor": "High Operating Costs",
                "severity": "Medium",
                "description": f"Operating expenses at {expense_ratio:.1f}% of revenue limit profitability"
            })

        # Generate recommendations
        recommendations.append("Conduct detailed expense analysis to identify cost-saving opportunities")
        recommendations.append("Implement monthly financial reviews and KPI tracking")
        recommendations.append(f"Benchmark performance against {industry} industry standards")

        if profit_margin < 10:
            recommendations.append("Focus on pricing strategy optimization to improve margins")

        recommendations.append("Consider diversifying revenue streams to reduce dependency")

        # Cost optimization strategies
        cost_optimization.append("Review vendor contracts and negotiate better terms")
        cost_optimization.append("Implement automated invoicing and payment systems")
        cost_optimization.append("Optimize inventory management to reduce carrying costs")
        cost_optimization.append("Consider energy-efficient equipment to reduce utility costs")
        cost_optimization.append("Evaluate outsourcing vs in-house for non-core activities")

        # Financial products
        if health_score >= 60:
            financial_products.append({
                "product": "Business Line of Credit",
                "provider": "HDFC Bank / ICICI Bank",
                "reason": "Good credit profile suitable for flexible credit line"
            })

        financial_products.append({
            "product": "Working Capital Loan",
            "provider": "Various NBFCs",
            "reason": "Support daily operations and manage cash flow cycles"
        })

        if revenue > 500000:
            financial_products.append({
                "product": "Invoice Financing",
                "provider": "Fintech platforms",
                "reason": "Unlock cash from pending receivables"
            })

        return {
            "insights": insights,
            "risks": risks,
            "recommendations": recommendations,
            "cost_optimization": cost_optimization,
            "financial_products": financial_products
        }

    def _parse_text_response(self, text: str) -> Dict[str, Any]:
        """Parse non-JSON text response into structured format"""
        return {
            "insights": [text[:200]],
            "risks": [],
            "recommendations": [],
            "cost_optimization": [],
            "financial_products": []
        }
