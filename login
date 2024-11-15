import React, { useState } from 'react';
import { Box, Divider } from '@mui/material';
import EventContainer from '../../components/EventContainer';
import Header from '../../components/Header';
import MenuContainer from '../../components/MenuContainer';
import ActionContainer from '../../components/ActionContainer';
import SnackBar from '../../components/SnackBar';
import { useNavigate } from 'react-router-dom';
import EventDetailsScreen from './EventDetailsScreen';

export const CircleInfo = () => {
    const [isMember, setIsMember] = useState(false);
    const [isJoined, setIsJoined] = useState(false);
    const [isToastOpen, setIsToastOpen] = useState(false);
    const [toastMessage, setToastMessage] = useState('');

    const navigate = useNavigate();

    // Function handlers for navigation
    const onClickHomeBtn = () => navigate('/Home');
    const onClickMyPageBtn = () => navigate('/MyPage');
    const onClickCircleMemberList = () => navigate('/CircleMemberList');
    const onClickCircleListBtn = () => navigate('/CircleList');

    // Handler for Join Button
    const onClickJoin = () => {
        setIsToastOpen(true);
        setIsJoined(true);
        setToastMessage('参加表明しました。');
    };

    return (
        <div className="Onboarding">
            <header className="App-header">
                <Header>サークルページ</Header>
                <Box sx={{ mt: 2 }} />

                {/* If user is a member, show EventDetailsScreen, else show a placeholder */}
                {isMember ? (
                    <EventDetailsScreen />
                ) : (
                    <Box sx={{ textAlign: 'center', mt: 4 }}>
                        <p>サークルに参加していません。</p>
                    </Box>
                )}

                <Divider sx={{ my: 2 }} />

                {/* Action Section */}
                <ActionContainer
                    title="アクション"
                    contents={
                        isMember
                            ? [
                                  {
                                      title: '編集',
                                      onClick: onClickCircleMemberList,
                                  },
                                  {
                                      title: 'メンバー一覧',
                                      onClick: onClickCircleMemberList,
                                  },
                                  {
                                      title: '承認待ちユーザー',
                                      onClick: onClickCircleMemberList,
                                  },
                                  {
                                      title: '戻る',
                                      onClick: onClickCircleListBtn,
                                  },
                              ]
                            : [
                                  {
                                      title: '参加表明',
                                      onClick: onClickJoin,
                                      disabled: isJoined,
                                  },
                                  {
                                      title: 'メンバー一覧',
                                      onClick: onClickCircleMemberList,
                                  },
                                  {
                                      title: '戻る',
                                      onClick: onClickCircleListBtn,
                                  },
                              ]
                    }
                />

                {/* Menu Section */}
                <MenuContainer
                    contents={[
                        {
                            title: 'マイページ',
                            onClick: onClickMyPageBtn,
                        },
                    ]}
                />

                {/* SnackBar Notification */}
                <SnackBar
                    open={isToastOpen}
                    message={toastMessage}
                    onClose={() => setIsToastOpen(false)}
                />
            </header>
        </div>
    );
};

export default CircleInfo;
