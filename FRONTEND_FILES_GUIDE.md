# 🎨 FRONTEND FILES - Copy Each Section to Separate Files

## ===== FILE 1: frontend/index.html =====

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Financial Health Assessment Tool</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>

## ===== FILE 2: frontend/vite.config.js =====

import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:8000',
        changeOrigin: true,
      },
    },
  },
})

## ===== FILE 3: frontend/tailwind.config.js =====

/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}

## ===== FILE 4: frontend/postcss.config.js =====

export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}

## ===== FILE 5: frontend/src/index.css =====

@tailwind base;
@tailwind components;
@tailwind utilities;

:root {
  font-family: Inter, system-ui, Avenir, Helvetica, Arial, sans-serif;
  line-height: 1.5;
  font-weight: 400;
}

body {
  margin: 0;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

#root {
  min-height: 100vh;
}

## ===== FILE 6: frontend/src/main.jsx =====

import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)

## ===== FILE 7: frontend/src/services/api.js =====

import axios from 'axios';

const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:8000';

const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const uploadFinancialData = async (file, companyName, industry) => {
  const formData = new FormData();
  formData.append('file', file);
  formData.append('company_name', companyName);
  formData.append('industry', industry);

  const response = await api.post('/api/assessments/upload', formData, {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  });

  return response.data;
};

export const getAssessments = async () => {
  const response = await api.get('/api/assessments/');
  return response.data;
};

export const getAssessment = async (id) => {
  const response = await api.get(`/api/assessments/${id}`);
  return response.data;
};

export default api;

## ===== FILE 8: frontend/src/App.jsx ===== 
## THIS IS A LARGE FILE - SEE NEXT ARTIFACT

NOTE: App.jsx is too large for this document. 
It will be provided as a separate downloadable file.
