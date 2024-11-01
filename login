import React, { useState } from 'react';
import OnboardingContainer from './components/OnboardingContainer';

const OnboardingScreen: React.FC = () => {
    const [currentScreen, setCurrentScreen] = useState(0);

    return (
        <>
            {currentScreen === 0 ? (
                <OnboardingContainer
                    title="このサービスの使い方"
                    description="JRI内で同じ興味・趣味を持つ仲間を見つけられます。サークルを探したり、作ったりして、業務以外での関わりを作ることができます。"
                    buttonText="次へ"
                    buttonVariant="outlined"
                    onButtonClick={() => setCurrentScreen(1)}
                />
            ) : (
                <OnboardingContainer
                    title="イベントに参加しよう！"
                    description="サークルに参加したらそのサークルのイベントをチェックしましょう。積極的にイベントに参加すると新しい繋がりができるかもしれません。"
                    buttonText="はじめる"
                    buttonVariant="contained"
                    onButtonClick={() => console.log('Navigate to login')}
                />
            )}
        </>
    );
};

export default OnboardingScreen;
