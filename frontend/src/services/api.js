import axios from 'axios';

const api = axios.create({
  baseURL: 'https://financial-health-tool-production.up.railway.app',
});

export const uploadFinancialData = async (file, companyName, industry) => {
  const formData = new FormData();
  formData.append('file', file);
  formData.append('company_name', companyName);
  formData.append('industry', industry);
  const response = await api.post('/api/assessments/upload', formData);
  return response.data;
};

export default api;