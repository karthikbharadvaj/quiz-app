import React, { useState } from 'react';
import { Box, Divider } from '@mui/material';
import Header from '../../components/Header';
import MenuContainer from '../../components/MenuContainer';
import ActionContainer from '../../components/ActionContainer';
import SnackBar from '../../components/SnackBar';
import EventDetailContainer from '../../components/EventDetailContainer';
import JoinEventContainer from '../../components/JoinEventContainer';
import { useNavigate } from 'react-router-dom';

const CircleInfo = () => {
    const [isMember, setIsMember] = useState(false);
    const [isJoined, setIsJoined] = useState(false);
    const [isToastOpen, setIsToastOpen] = useState(false);
    const [toastMessage, setToastMessage] = useState('');
    const [isModalOpen, setIsModalOpen] = useState(false);

    const navigate = useNavigate();

    // Event data
    const event = {
        imageSrc: '/images/soccer.jpg',
        title: 'サッカーの練習 & 試合',
        date: '2024/11/22',
        location: '大田区総合体育館',
        overview: '体育館でサッカーの簡単な練習と試合を行います。見学だけでも構いませんので、興味のある方はぜひご参加ください。',
        tags: ['サッカー', '20代', '30代'],
    };

    const onClickJoin = () => {
        setIsModalOpen(true);
    };

    const handleCloseModal = () => {
        setIsModalOpen(false);
    };

    const handleConfirmJoin = () => {
        setIsToastOpen(true);
        setIsJoined(true);
        setToastMessage('参加表明しました。');
        setIsModalOpen(false);
    };

    return (
        <div className="Onboarding">
            <header className="App-header">
                <Header>サークルページ</Header>
                <Box sx={{ mt: 2 }} />

                {/* If user is a member, show event details */}
                {isMember ? (
                    <EventDetailContainer
                        imageSrc={event.imageSrc}
                        title={event.title}
                        date={event.date}
                        location={event.location}
                        overview={event.overview}
                        tags={event.tags}
                        onJoinClick={onClickJoin}
                    />
                ) : (
                    <Box sx={{ textAlign: 'center', mt: 4 }}>
                        <Typography variant="body1">サークルに参加していません。</Typography>
                    </Box>
                )}

                <Divider sx={{ my: 2 }} />

                <ActionContainer
                    title="アクション"
                    contents={
                        isMember
                            ? [
                                  { title: '編集', onClick: () => navigate('/CircleMemberList') },
                                  { title: 'メンバー一覧', onClick: () => navigate('/CircleMemberList') },
                                  { title: '戻る', onClick: () => navigate('/CircleList') },
                              ]
                            : [
                                  { title: '参加表明', onClick: onClickJoin, disabled: isJoined },
                                  { title: '戻る', onClick: () => navigate('/CircleList') },
                              ]
                    }
                />

                <MenuContainer
                    contents={[{ title: 'マイページ', onClick: () => navigate('/MyPage') }]}
                />

                <SnackBar
                    open={isToastOpen}
                    message={toastMessage}
                    onClose={() => setIsToastOpen(false)}
                />

                <JoinEventContainer
                    open={isModalOpen}
                    onClose={handleCloseModal}
                    onConfirmJoin={handleConfirmJoin}
                    eventTitle={event.title}
                />
            </header>
        </div>
    );
};

export default CircleInfo;
