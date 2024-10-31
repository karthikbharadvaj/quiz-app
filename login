import React from 'react';

interface OutlineButtonProps {
    title: string;
    onClick: () => void;
}

const OutlineButton: React.FC<OutlineButtonProps> = ({ title, onClick }) => {
    return (
        <button className="outline-button" onClick={onClick}>
            {title}
        </button>
    );
};

export default OutlineButton;


import React from 'react';

interface FilledButtonProps {
    title: string;
    onClick: () => void;
}

const FilledButton: React.FC<FilledButtonProps> = ({ title, onClick }) => {
    return (
        <button className="filled-button" onClick={onClick}>
            {title}
        </button>
    );
};

export default FilledButton;

.onboarding-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background-color: #eff3f4;
    padding: 20px;
    height: 100vh;
}

.onboarding-image {
    width: 100px;
    height: 100px;
    margin-bottom: 20px;
}

.onboarding-title {
    font-size: 18px;
    font-weight: bold;
    margin-bottom: 10px;
}

.onboarding-description {
    font-size: 16px;
    text-align: center;
    margin-bottom: 20px;
}

.outline-button {
    width: 295px;
    height: 52px;
    border-radius: 26px;
    background-color: #ffffff;
    border: 1px solid #429AD0;
    color: #429AD0;
    font-size: 16px;
    cursor: pointer;
}

.filled-button {
    width: 295px;
    height: 52px;
    border-radius: 26px;
    background-color: #429AD0;
    color: #ffffff;
    font-size: 16px;
    cursor: pointer;
}

import React, { useState } from 'react';
import './OnboardingContainer.css';
import OutlineButton from '../buttons/OutlineButton';
import FilledButton from '../buttons/FilledButton';

const OnboardingContainer: React.FC = () => {
    const [currentScreen, setCurrentScreen] = useState(0);

    const handleNext = () => {
        setCurrentScreen(1);
    };

    const handleStart = () => {
        console.log("Navigate to login");
    };

    return (
        <div className="onboarding-container">
            {currentScreen === 0 ? (
                <>
                    <img src={require('../images/lightbulb.png')} alt="Lightbulb" className="onboarding-image" />
                    <h2 className="onboarding-title">このサービスの使い方</h2>
                    <p className="onboarding-description">
                        JRI内で同じ興味・趣味を持つ仲間を見つけられます。サークルを探したり、作ったりして、業務以外での関わりを作ることができます。
                    </p>
                    <OutlineButton title="次へ" onClick={handleNext} />
                </>
            ) : (
                <>
                    <img src={require('../images/event.png')} alt="Event" className="onboarding-image" />
                    <h2 className="onboarding-title">イベントに参加しよう！</h2>
                    <p className="onboarding-description">
                        サークルに参加したらそのサークルのイベントをチェックしましょう。積極的にイベントに参加すると新しい繋がりができるかもしれません。
                    </p>
                    <FilledButton title="はじめる" onClick={handleStart} />
                </>
            )}
        </div>
    );
};

export default OnboardingContainer;

