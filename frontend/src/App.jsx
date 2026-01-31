import { useState } from 'react';
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { uploadFinancialData } from './services/api';

function App() {
  const [file, setFile] = useState(null);
  const [companyName, setCompanyName] = useState('');
  const [industry, setIndustry] = useState('');
  const [loading, setLoading] = useState(false);
  const [results, setResults] = useState(null);
  const [error, setError] = useState('');

  const industries = [
    'Manufacturing',
    'Retail',
    'Agriculture',
    'Services',
    'Logistics',
    'E-commerce',
    'Technology',
    'Healthcare',
    'Finance',
    'Other'
  ];

  const handleFileChange = (e) => {
    const selectedFile = e.target.files[0];
    if (selectedFile) {
      const fileType = selectedFile.name.split('.').pop().toLowerCase();
      if (['csv', 'xlsx', 'xls', 'pdf'].includes(fileType)) {
        setFile(selectedFile);
        setError('');
      } else {
        setError('Please upload a CSV, XLSX, or PDF file');
        setFile(null);
      }
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    if (!file || !companyName || !industry) {
      setError('Please fill in all fields and select a file');
      return;
    }

    setLoading(true);
    setError('');
    setResults(null);

    try {
      const data = await uploadFinancialData(file, companyName, industry);
      setResults(data);
    } catch (err) {
      setError(err.response?.data?.detail || 'Error analyzing financial data. Please try again.');
      console.error('Upload error:', err);
    } finally {
      setLoading(false);
    }
  };

  const getRiskColor = (riskLevel) => {
    const colors = {
      'Low': 'text-green-600 bg-green-100',
      'Medium': 'text-yellow-600 bg-yellow-100',
      'High': 'text-orange-600 bg-orange-100',
      'Critical': 'text-red-600 bg-red-100'
    };
    return colors[riskLevel] || 'text-gray-600 bg-gray-100';
  };

  const getScoreColor = (score) => {
    if (score >= 75) return 'text-green-600';
    if (score >= 50) return 'text-yellow-600';
    if (score >= 25) return 'text-orange-600';
    return 'text-red-600';
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-600 via-purple-700 to-indigo-800 py-12 px-4">
      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <div className="text-center mb-12">
          <h1 className="text-5xl font-bold text-white mb-4">
            Financial Health Assessment Tool
          </h1>
          <p className="text-xl text-purple-100">
            AI-powered Financial Analysis for SMEs
          </p>
          <p className="text-sm text-purple-200 mt-2">
            Career Carnival 2026 | HCL & GUVI
          </p>
        </div>

        {/* Upload Form */}
        <div className="bg-white rounded-2xl shadow-2xl p-8 mb-8">
          <h2 className="text-3xl font-bold text-gray-800 mb-6">Upload Financial Data</h2>
          
          <form onSubmit={handleSubmit} className="space-y-6">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Company Name *
              </label>
              <input
                type="text"
                value={companyName}
                onChange={(e) => setCompanyName(e.target.value)}
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                placeholder="Enter company name"
                required
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Industry *
              </label>
              <select
                value={industry}
                onChange={(e) => setIndustry(e.target.value)}
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                required
              >
                <option value="">Select Industry</option>
                {industries.map((ind) => (
                  <option key={ind} value={ind}>{ind}</option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Financial Data File * (CSV, XLSX, or PDF)
              </label>
              <input
                type="file"
                onChange={handleFileChange}
                accept=".csv,.xlsx,.xls,.pdf"
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                required
              />
              {file && (
                <p className="mt-2 text-sm text-green-600">
                  ✓ {file.name} selected
                </p>
              )}
            </div>

            {error && (
              <div className="bg-red-50 border border-red-200 rounded-lg p-4">
                <p className="text-red-600">{error}</p>
              </div>
            )}

            <button
              type="submit"
              disabled={loading}
              className="w-full bg-gradient-to-r from-purple-600 to-indigo-600 text-white font-bold py-4 px-6 rounded-lg hover:from-purple-700 hover:to-indigo-700 transition duration-200 disabled:opacity-50 disabled:cursor-not-allowed shadow-lg"
            >
              {loading ? 'Analyzing...' : 'Analyze Financial Health'}
            </button>
          </form>
        </div>

        {/* Results */}
        {results && (
          <div className="space-y-8">
            {/* Health Score Card */}
            <div className="bg-white rounded-2xl shadow-2xl p-8">
              <h2 className="text-3xl font-bold text-gray-800 mb-6">Assessment Results</h2>
              
              <div className="grid md:grid-cols-2 gap-6 mb-8">
                <div className="text-center p-6 bg-gradient-to-br from-purple-50 to-indigo-50 rounded-xl">
                  <h3 className="text-lg font-semibold text-gray-700 mb-2">Financial Health Score</h3>
                  <p className={`text-6xl font-bold ${getScoreColor(results.health_score)}`}>
                    {results.health_score.toFixed(1)}
                  </p>
                  <p className="text-gray-600 mt-2">out of 100</p>
                </div>

                <div className="text-center p-6 bg-gradient-to-br from-purple-50 to-indigo-50 rounded-xl">
                  <h3 className="text-lg font-semibold text-gray-700 mb-2">Risk Level</h3>
                  <span className={`inline-block px-6 py-3 rounded-full text-xl font-bold ${getRiskColor(results.risk_level)}`}>
                    {results.risk_level}
                  </span>
                </div>
              </div>

              {/* Financial Metrics */}
              <div className="grid md:grid-cols-4 gap-4">
                <div className="p-4 bg-blue-50 rounded-lg">
                  <p className="text-sm text-gray-600">Total Revenue</p>
                  <p className="text-2xl font-bold text-blue-600">
                    ₹{results.financial_metrics.total_revenue.toLocaleString()}
                  </p>
                </div>
                <div className="p-4 bg-red-50 rounded-lg">
                  <p className="text-sm text-gray-600">Total Expenses</p>
                  <p className="text-2xl font-bold text-red-600">
                    ₹{results.financial_metrics.total_expenses.toLocaleString()}
                  </p>
                </div>
                <div className="p-4 bg-green-50 rounded-lg">
                  <p className="text-sm text-gray-600">Net Profit</p>
                  <p className="text-2xl font-bold text-green-600">
                    ₹{results.financial_metrics.net_profit.toLocaleString()}
                  </p>
                </div>
                <div className="p-4 bg-purple-50 rounded-lg">
                  <p className="text-sm text-gray-600">Profit Margin</p>
                  <p className="text-2xl font-bold text-purple-600">
                    {results.financial_metrics.profit_margin.toFixed(2)}%
                  </p>
                </div>
              </div>
            </div>

            {/* Charts */}
            {results.monthly_data && results.monthly_data.length > 0 && (
              <div className="bg-white rounded-2xl shadow-2xl p-8">
                <h2 className="text-2xl font-bold text-gray-800 mb-6">Financial Trends</h2>
                
                <div className="grid md:grid-cols-2 gap-8">
                  <div>
                    <h3 className="text-lg font-semibold text-gray-700 mb-4">Monthly Revenue & Expenses</h3>
                    <ResponsiveContainer width="100%" height={300}>
                      <LineChart data={results.monthly_data}>
                        <CartesianGrid strokeDasharray="3 3" />
                        <XAxis dataKey="month" />
                        <YAxis />
                        <Tooltip />
                        <Legend />
                        <Line type="monotone" dataKey="revenue" stroke="#8b5cf6" strokeWidth={2} name="Revenue" />
                        <Line type="monotone" dataKey="expenses" stroke="#ef4444" strokeWidth={2} name="Expenses" />
                      </LineChart>
                    </ResponsiveContainer>
                  </div>

                  <div>
                    <h3 className="text-lg font-semibold text-gray-700 mb-4">Revenue vs Expenses Comparison</h3>
                    <ResponsiveContainer width="100%" height={300}>
                      <BarChart data={results.monthly_data}>
                        <CartesianGrid strokeDasharray="3 3" />
                        <XAxis dataKey="month" />
                        <YAxis />
                        <Tooltip />
                        <Legend />
                        <Bar dataKey="revenue" fill="#8b5cf6" name="Revenue" />
                        <Bar dataKey="expenses" fill="#ef4444" name="Expenses" />
                      </BarChart>
                    </ResponsiveContainer>
                  </div>
                </div>
              </div>
            )}

            {/* AI Analysis */}
            {results.ai_analysis && (
              <div className="bg-white rounded-2xl shadow-2xl p-8">
                <h2 className="text-2xl font-bold text-gray-800 mb-6">AI-Powered Analysis</h2>

                {/* Insights */}
                {results.ai_analysis.insights && results.ai_analysis.insights.length > 0 && (
                  <div className="mb-8">
                    <h3 className="text-xl font-semibold text-gray-700 mb-4 flex items-center">
                      <span className="text-2xl mr-2">💡</span> Key Insights
                    </h3>
                    <ul className="space-y-3">
                      {results.ai_analysis.insights.map((insight, index) => (
                        <li key={index} className="flex items-start">
                          <span className="text-purple-600 mr-2">•</span>
                          <span className="text-gray-700">{insight}</span>
                        </li>
                      ))}
                    </ul>
                  </div>
                )}

                {/* Risk Factors */}
                {results.ai_analysis.risks && results.ai_analysis.risks.length > 0 && (
                  <div className="mb-8">
                    <h3 className="text-xl font-semibold text-gray-700 mb-4 flex items-center">
                      <span className="text-2xl mr-2">⚠️</span> Risk Factors
                    </h3>
                    <div className="space-y-3">
                      {results.ai_analysis.risks.map((risk, index) => (
                        <div key={index} className="border-l-4 border-orange-500 pl-4 py-2 bg-orange-50 rounded">
                          <p className="font-semibold text-gray-800">{risk.factor || risk}</p>
                          {risk.severity && (
                            <span className={`inline-block px-2 py-1 rounded text-xs font-semibold mt-1 ${
                              risk.severity === 'High' ? 'bg-red-100 text-red-700' : 'bg-yellow-100 text-yellow-700'
                            }`}>
                              {risk.severity} Severity
                            </span>
                          )}
                          {risk.description && (
                            <p className="text-sm text-gray-600 mt-1">{risk.description}</p>
                          )}
                        </div>
                      ))}
                    </div>
                  </div>
                )}

                {/* Recommendations */}
                {results.ai_analysis.recommendations && results.ai_analysis.recommendations.length > 0 && (
                  <div className="mb-8">
                    <h3 className="text-xl font-semibold text-gray-700 mb-4 flex items-center">
                      <span className="text-2xl mr-2">✅</span> Recommendations
                    </h3>
                    <ul className="space-y-3">
                      {results.ai_analysis.recommendations.map((rec, index) => (
                        <li key={index} className="flex items-start bg-green-50 p-3 rounded-lg">
                          <span className="text-green-600 mr-2 font-bold">{index + 1}.</span>
                          <span className="text-gray-700">{rec}</span>
                        </li>
                      ))}
                    </ul>
                  </div>
                )}

                {/* Cost Optimization */}
                {results.ai_analysis.cost_optimization && results.ai_analysis.cost_optimization.length > 0 && (
                  <div className="mb-8">
                    <h3 className="text-xl font-semibold text-gray-700 mb-4 flex items-center">
                      <span className="text-2xl mr-2">💰</span> Cost Optimization Strategies
                    </h3>
                    <ul className="space-y-3">
                      {results.ai_analysis.cost_optimization.map((strategy, index) => (
                        <li key={index} className="flex items-start">
                          <span className="text-indigo-600 mr-2">▸</span>
                          <span className="text-gray-700">{strategy}</span>
                        </li>
                      ))}
                    </ul>
                  </div>
                )}

                {/* Financial Products */}
                {results.ai_analysis.financial_products && results.ai_analysis.financial_products.length > 0 && (
                  <div>
                    <h3 className="text-xl font-semibold text-gray-700 mb-4 flex items-center">
                      <span className="text-2xl mr-2">🏦</span> Recommended Financial Products
                    </h3>
                    <div className="grid md:grid-cols-2 gap-4">
                      {results.ai_analysis.financial_products.map((product, index) => (
                        <div key={index} className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition">
                          <h4 className="font-semibold text-gray-800">{product.product || product}</h4>
                          {product.provider && (
                            <p className="text-sm text-purple-600 mt-1">{product.provider}</p>
                          )}
                          {product.reason && (
                            <p className="text-sm text-gray-600 mt-2">{product.reason}</p>
                          )}
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            )}
          </div>
        )}

        {/* Footer */}
        <div className="text-center mt-12 text-white">
          <p className="text-sm">
            Built by Vignesh Yadala | Career Carnival 2026 | HCL & GUVI
          </p>
        </div>
      </div>
    </div>
  );
}

export default App;
