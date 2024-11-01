import React from 'react';
import { Box } from '@mui/material';

interface PaginationDotsProps {
    activeIndex: number;
    total: number;
}

const PaginationDots: React.FC<PaginationDotsProps> = ({ activeIndex, total }) => {
    return (
        <Box display="flex" justifyContent="center" mt={2}>
            {Array.from({ length: total }).map((_, index) => (
                <Box
                    key={index}
                    sx={{
                        width: 8,
                        height: 8,
                        borderRadius: '50%',
                        backgroundColor: index === activeIndex ? '#429AD0' : '#c4c4c4',
                        margin: '0 4px',
                    }}
                />
            ))}
        </Box>
    );
};

export default PaginationDots;

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

import React, { useState } from 'react';
import OnboardingContainer from './components/OnboardingContainer';

const App: React.FC = () => {
    const [currentScreen, setCurrentScreen] = useState(0);

    const screens = [
        {
            imageSrc: '/path/to/lightbulb.png',
            title: 'このサービスの使い方',
            description: 'JRI内で同じ興味・趣味を持つ仲間を見つけられます。サークルを探したり、作ったりして、業務以外での関わりを作ることができます。',
            buttonText: '次へ',
            buttonVariant: 'outlined' as const,
            onButtonClick: () => setCurrentScreen(1),
        },
        {
            imageSrc: '/path/to/event.png',
            title: 'イベントに参加しよう！',
            description: 'サークルに参加したらそのサークルのイベントをチェックしましょう。積極的にイベントに参加すると新しい繋がりができるかもしれません。',
            buttonText: 'はじめる',
            buttonVariant: 'contained' as const,
            onButtonClick: () => console.log('Navigate to login'),
        },
    ];

    const currentScreenData = screens[currentScreen];

    return (
        <OnboardingContainer
            imageSrc={currentScreenData.imageSrc}
            title={currentScreenData.title}
            description={currentScreenData.description}
            buttonText={currentScreenData.buttonText}
            buttonVariant={currentScreenData.buttonVariant}
            onButtonClick={currentScreenData.onButtonClick}
            activeIndex={currentScreen}
            totalScreens={screens.length}
        />
    );
};

export default App;

