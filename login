import React from 'react';
import { Box, TextField, Typography } from '@mui/material';
import DefaultButton from './buttons/DefaultButton';

interface LoginContainerProps {
    title: string;
    idLabel: string;
    passwordLabel: string;
    buttonText: string;
    onLogin: () => void;
}

const LoginContainer: React.FC<LoginContainerProps> = ({ 
    title, 
    idLabel, 
    passwordLabel, 
    buttonText, 
    onLogin 
}) => {
    return (
        <div
            style={{
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                minHeight: '100vh',
                backgroundColor: '#eff3f4',
            }}
        >
            <Box
                sx={{
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                    justifyContent: 'center',
                    width: '100%',
                    maxWidth: '400px',
                    backgroundColor: '#FFFFFF',
                    padding: 3,
                    borderRadius: '8px',
                    boxShadow: '0px 4px 12px rgba(0, 0, 0, 0.1)',
                }}
            >
                <Typography variant="h5" sx={{ mb: 3 }}>
                    {title}
                </Typography>

                <TextField
                    label={idLabel}
                    placeholder={idLabel}
                    variant="outlined"
                    fullWidth
                    sx={{ mb: 2, backgroundColor: '#FFFFFF' }}
                />

                <TextField
                    label={passwordLabel}
                    placeholder={passwordLabel}
                    type="password"
                    variant="outlined"
                    fullWidth
                    sx={{ mb: 3, backgroundColor: '#FFFFFF' }}
                />

                <DefaultButton title={buttonText} onClick={onLogin} />
            </Box>
        </div>
    );
};

export default LoginContainer;
