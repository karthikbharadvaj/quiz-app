import React from 'react';
import { Box, Button, Typography } from '@mui/material';

interface OnboardingContainerProps {
    title: string;
    description: string;
    buttonText: string;
    buttonVariant: 'outlined' | 'contained'; // Specify variant based on the button type
    onButtonClick: () => void;
}

const OnboardingContainer: React.FC<OnboardingContainerProps> = ({
    title,
    description,
    buttonText,
    buttonVariant,
    onButtonClick,
}) => {
    return (
        <Box
            sx={{
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                justifyContent: 'center',
                minHeight: '100vh',
                backgroundColor: '#eff3f4',
                padding: 2,
            }}
        >
            <Typography variant="h5" color="#818181" sx={{ mb: 1 }}>
                {title}
            </Typography>
            <Typography variant="body1" color="textSecondary" align="center" sx={{ mb: 3 }}>
                {description}
            </Typography>
            <Button
                variant={buttonVariant}
                sx={{
                    width: '295px',
                    height: '52px',
                    borderRadius: '26px',
                    backgroundColor: buttonVariant === 'contained' ? '#429AD0' : '#FFFFFF',
                    color: buttonVariant === 'contained' ? '#FFFFFF' : '#429AD0',
                    borderColor: '#429AD0',
                }}
                onClick={onButtonClick}
            >
                {buttonText}
            </Button>
        </Box>
    );
};

export default OnboardingContainer;
