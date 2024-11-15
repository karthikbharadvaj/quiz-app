import React from 'react';
import { Box, Typography, Button, Chip } from '@mui/material';

interface EventDetailsProps {
    imageSrc: string;
    title: string;
    date: string;
    location: string;
    overview: string;
    tags: string[];
    onJoinClick: () => void;
}

const EventDetails = ({ imageSrc, title, date, location, overview, tags, onJoinClick }: EventDetailsProps) => {
    return (
        <Box
            sx={{
                padding: 2,
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'center',
                backgroundColor: '#eff3f4',
                minHeight: '100vh',
            }}
        >
            <img
                src={imageSrc}
                alt={title}
                style={{ width: '100%', maxHeight: '200px', borderRadius: '8px', objectFit: 'cover', marginBottom: '16px' }}
            />
            <Typography variant="h6" sx={{ fontWeight: 'bold', marginBottom: '8px' }}>
                {title}
            </Typography>

            <Box sx={{ display: 'flex', gap: 1, marginBottom: '16px' }}>
                {tags.map((tag, index) => (
                    <Chip key={index} label={tag} />
                ))}
            </Box>

            <Button
                variant="contained"
                color="primary"
                fullWidth
                sx={{
                    height: '52px',
                    borderRadius: '26px',
                    backgroundColor: '#429AD0',
                    color: '#FFFFFF',
                    fontWeight: 'bold',
                    marginBottom: '16px',
                }}
                onClick={onJoinClick}
            >
                参加する
            </Button>

            <Typography variant="subtitle1" sx={{ marginBottom: '8px' }}>
                日時
            </Typography>
            <Typography variant="body2" sx={{ marginBottom: '16px' }}>
                {date}
            </Typography>

            <Typography variant="subtitle1" sx={{ marginBottom: '8px' }}>
                場所
            </Typography>
            <Typography variant="body2" sx={{ marginBottom: '16px' }}>
                {location}
            </Typography>

            <Typography variant="subtitle1" sx={{ marginBottom: '8px' }}>
                イベント概要
            </Typography>
            <Typography variant="body2">{overview}</Typography>
        </Box>
    );
};

export default EventDetails;
2. JoinEventModal Component
This modal component will pop up when the user clicks the 参加する (Join) button.

JoinEventModal.tsx
import React from 'react';
import { Dialog, DialogTitle, DialogContent, TextField, Button, Box } from '@mui/material';

interface JoinEventModalProps {
    open: boolean;
    onClose: () => void;
}

const JoinEventModal = ({ open, onClose }: JoinEventModalProps) => {
    return (
        <Dialog open={open} onClose={onClose} maxWidth="xs" fullWidth>
            <DialogTitle>イベント参加</DialogTitle>
            <DialogContent>
                <Typography variant="body2" sx={{ marginBottom: '16px' }}>
                    「サッカーの練習 & 試合」のイベントに参加しますか？参加する場合、管理者に通知が届きます。
                </Typography>

                <TextField
                    label="名前"
                    placeholder="名前"
                    fullWidth
                    sx={{ marginBottom: '16px' }}
                />
                <TextField
                    label="所属部署"
                    placeholder="所属部署"
                    fullWidth
                    sx={{ marginBottom: '16px' }}
                />

                <Box sx={{ display: 'flex', justifyContent: 'space-between', marginTop: '16px' }}>
                    <Button variant="contained" color="primary" onClick={onClose}>
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
3. EventDetailsScreen
This is the main screen that brings everything together, including the EventDetails and JoinEventModal components.

EventDetailsScreen.tsx
import React, { useState } from 'react';
import EventDetails from '../components/EventDetails';
import JoinEventModal from '../components/JoinEventModal';

const EventDetailsScreen = () => {
    const [isModalOpen, setModalOpen] = useState(false);

    const event = {
        imageSrc: '/images/soccer.jpg',
        title: 'サッカーの練習 & 試合',
        date: '2024/11/22',
        location: '大田区総合体育館',
        overview: '体育館でサッカーの簡単な練習と試合を行います。見学だけでも構わないのでぜひ興味のある方はご参加ください。',
        tags: ['サッカー', '20代', '30代'],
    };

    const handleJoinClick = () => {
        setModalOpen(true);
    };

    const handleCloseModal = () => {
        setModalOpen(false);
    };

    return (
        <>
            <EventDetails
                imageSrc={event.imageSrc}
                title={event.title}
                date={event.date}
                location={event.location}
                overview={event.overview}
                tags={event.tags}
                onJoinClick={handleJoinClick}
            />
            <JoinEventModal open={isModalOpen} onClose={handleCloseModal} />
        </>
    );
};

export default EventDetailsScreen;
Explanation
EventDetails Component: Displays the main information of the event, including the image, title, tags, date, location, and overview. It also includes a button to join the event.
