import React, { useState } from 'react';
import { Box, Divider } from '@mui/material';
import EventContainer from '../../components/EventContainer';
import Header from '../../components/Header';
import MenuContainer from '../../components/MenuContainer';
import ActionContainer from '../../components/ActionContainer';
import SnackBar from '../../components/SnackBar';
import EventDetailsScreen from './EventDetailsScreen';
import JoinEventModal from '../../components/JoinEventModal';
import { useNavigate } from 'react-router-dom';

export const CircleInfo = () => {
    const [isMember, setIsMember] = useState(false);
    const [isJoined, setIsJoined] = useState(false);
    const [isToastOpen, setIsToastOpen] = useState(false);
    const [toastMessage, setToastMessage] = useState('');
    const [isModalOpen, setIsModalOpen] = useState(false);

    const navigate = useNavigate();

    // Handler for Join Button Click
    const onClickJoin = () => {
        setIsModalOpen(true);
    };

    // Handler for Confirming Join in Modal
    const onConfirmJoin = () => {
        setIsToastOpen(true);
        setIsJoined(true);
        setToastMessage('参加表明しました。');
        setIsModalOpen(false);
    };

    // Close the modal
    const onCloseModal = () => {
        setIsModalOpen(false);
    };

    // Navigation Handlers
    const onClickHomeBtn = () => navigate('/Home');
    const onClickMyPageBtn = () => navigate('/MyPage');
    const onClickCircleMemberList = () => navigate('/CircleMemberList');
    const onClickCircleListBtn = () => navigate('/CircleList');

    return (
        <div className="Onboarding">
            <header className="App-header">
                <Header>サークルページ</Header>
                <Box sx={{ mt: 2 }} />

                {/* Display EventDetailsScreen if user is a member, otherwise show placeholder */}
                {isMember ? (
                    <EventDetailsScreen onJoinClick={onClickJoin} />
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

                {/* Join Event Modal */}
                <JoinEventModal
                    open={isModalOpen}
                    onClose={onCloseModal}
                    onConfirm={onConfirmJoin}
                />
            </header>
        </div>
    );
};

export default CircleInfo;
New JoinEventModal.tsx Component
This is the modal that pops up when the user clicks the 参加する (Join) button.

typescript
Copy code
import React from 'react';
import { Dialog, DialogTitle, DialogContent, TextField, Button, Box, Typography } from '@mui/material';

interface JoinEventModalProps {
    open: boolean;
    onClose: () => void;
    onConfirm: () => void;
}

const JoinEventModal = ({ open, onClose, onConfirm }: JoinEventModalProps) => {
    return (
        <Dialog open={open} onClose={onClose} maxWidth="xs" fullWidth>
            <DialogTitle>イベント参加</DialogTitle>
            <DialogContent>
                <Typography variant="body2" sx={{ mb: 2 }}>
                    「サッカーの練習 & 試合」のイベントに参加しますか？参加する場合、管理者に通知が届きます。
                </Typography>

                <TextField
                    label="名前"
                    placeholder="名前を入力してください"
                    fullWidth
                    sx={{ mb: 2 }}
                />
                <TextField
                    label="所属部署"
                    placeholder="所属部署を入力してください"
                    fullWidth
                    sx={{ mb: 3 }}
                />

                <Box sx={{ display: 'flex', justifyContent: 'space-between', mt: 2 }}>
                    <Button variant="contained" color="primary" onClick={onConfirm}>
                        参加
                    </Button>
                    <Button variant="outlined" color="secondary" onClick={onClose}>
                        キャンセル
                    </Button>
                </Box>
            </DialogContent>
        </Dialog>
    );
};

export default JoinEventModal;
