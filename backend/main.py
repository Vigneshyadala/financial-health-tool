from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import assessments
from app.models.database import init_db

app = FastAPI(
    title="Financial Health Assessment API",
    description="AI-powered Financial Health Assessment Tool for SMEs",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify your frontend domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize database
@app.on_event("startup")
async def startup_event():
    init_db()

# Include routers
app.include_router(assessments.router)

@app.get("/")
async def root():
    return {
        "message": "Financial Health Assessment API",
        "version": "1.0.0",
        "docs": "/docs"
    }

@app.get("/health")
async def health_check():
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
