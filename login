import React from 'react';
import { useNavigate } from 'react-router-dom';

const Onboarding1: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="onboarding-container">
      <h1>このサービスの使い方</h1>
      <p>サービスの詳細説明がここに入ります。</p>
      <button onClick={() => navigate('/onboarding2')}>次へ</button>
      <a href="#" onClick={() => navigate('/login')} className="skip-link">Skip</a>
    </div>
  );
};

export default Onboarding1;

import React from 'react';
import { useNavigate } from 'react-router-dom';

const Onboarding2: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="onboarding-container">
      <h1>イベントに参加しよう！</h1>
      <p>イベントの詳細説明がここに入ります。</p>
      <button onClick={() => navigate('/login')}>Get Started</button>
      <a href="#" onClick={() => navigate('/login')} className="skip-link">Skip</a>
    </div>
  );
};

export default Onboarding2;

import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';

const Login: React.FC = () => {
  const [id, setId] = useState<string>('');
  const [password, setPassword] = useState<string>('');
  const navigate = useNavigate();

  const handleLogin = () => {
    // Add login logic
    navigate('/home');
  };

  return (
    <div className="login-container">
      <h1>Login</h1>
      <input
        type="text"
        placeholder="ID"
        value={id}
        onChange={(e) => setId(e.target.value)}
      />
      <input
        type="password"
        placeholder="パスワード"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />
      <button onClick={handleLogin}>Login</button>
    </div>
  );
};

export default Login;

import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Onboarding1 from './Onboarding1';
import Onboarding2 from './Onboarding2';
import Login from './Login';
import Home from './Home';

const App: React.FC = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Onboarding1 />} />
        <Route path="/onboarding2" element={<Onboarding2 />} />
        <Route path="/login" element={<Login />} />
        <Route path="/home" element={<Home />} />
      </Routes>
    </Router>
  );
};

export default App;