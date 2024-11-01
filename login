import React from 'react';
import { Box, TextField, Typography } from '@mui/material';
import DefaultButton from '../components/buttons/DefaultButton';

const Login: React.FC = () => {
    const handleLogin = () => {
        // Handle login action (e.g., form submission or API call)
        console.log('Login clicked');
    };

    return (
        <Box
            sx={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                minHeight: '100vh',
                backgroundColor: '#eff3f4',
                padding: 3,
            }}
        >
            <Typography variant="h5" sx={{ mb: 3 }}>
                Login
            </Typography>

            <TextField
                label="ID"
                placeholder="ID"
                variant="outlined"
                fullWidth
                sx={{ mb: 2, backgroundColor: '#FFFFFF' }}
            />
            
            <TextField
                label="パスワード"
                placeholder="パスワード"
                type="password"
                variant="outlined"
                fullWidth
                sx={{ mb: 3, backgroundColor: '#FFFFFF' }}
            />
            
            <DefaultButton title="Login" onClick={handleLogin} />
        </Box>
    );
};

export default Login;
