import React from 'react';
import { Box, Button, Typography } from '@mui/material';
import PaginationDots from './PaginationDots';

interface OnboardingContainerProps {
    imageSrc: string;
    title: string;
    description: string;
    buttonText: string;
    buttonVariant: 'outlined' | 'contained';
    onButtonClick: () => void;
    activeIndex: number;
    totalScreens: number;
}

const OnboardingContainer: React.FC<OnboardingContainerProps> = ({
    imageSrc,
    title,
    description,
    buttonText,
    buttonVariant,
    onButtonClick,
    activeIndex,
    totalScreens,
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
            <img src={imageSrc} alt={title} style={{ width: 100, height: 100, marginBottom: 20 }} />
            <Typography variant="h5" color="#818181" sx={{ mb: 1 }}>
                {title}
            </Typography>
            <Typography variant="body1" color="textSecondary" align="center" sx={{ mb: 3 }}>
                {description}
            </Typography>
            <PaginationDots activeIndex={activeIndex} total={totalScreens} />
            <Button
                variant={buttonVariant}
                sx={{
                    width: '295px',
                    height: '52px',
                    borderRadius: '26px',
                    backgroundColor: buttonVariant === 'contained' ? '#429AD0' : '#FFFFFF',
                    color: buttonVariant === 'contained' ? '#FFFFFF' : '#429AD0',
                    borderColor: '#429AD0',
                    mt: 3,
                }}
                onClick={onButtonClick}
            >
                {buttonText}
            </Button>
        </Box>
    );
};

export default OnboardingContainer;
