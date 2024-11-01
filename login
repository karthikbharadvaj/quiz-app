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
        <Box
            sx={{
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
                    width: '100%',
                    maxWidth: '400px',
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
                    sx={{
                        mb: 2,
                        backgroundColor: '#FFFFFF',
                        '& .MuiOutlinedInput-root': {
                            '& fieldset': {
                                borderColor: '#73C6C8', // Custom border color
                            },
                            '&:hover fieldset': {
                                borderColor: '#73C6C8',
                            },
                            '&.Mui-focused fieldset': {
                                borderColor: '#73C6C8',
                            },
                        },
                    }}
                />

                <TextField
                    label={passwordLabel}
                    placeholder={passwordLabel}
                    type="password"
                    variant="outlined"
                    fullWidth
                    sx={{
                        mb: 3,
                        backgroundColor: '#FFFFFF',
                        '& .MuiOutlinedInput-root': {
                            '& fieldset': {
                                borderColor: '#73C6C8', // Custom border color
                            },
                            '&:hover fieldset': {
                                borderColor: '#73C6C8',
                            },
                            '&.Mui-focused fieldset': {
                                borderColor: '#73C6C8',
                            },
                        },
                    }}
                />

                <DefaultButton title={buttonText} onClick={onLogin} />
            </Box>
        </Box>
    );
};

export default LoginContainer;
