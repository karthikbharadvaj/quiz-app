1. EventTag Component
A reusable component for rendering event tags.

components/EventTag.tsx
import React from 'react';
import { Chip } from '@mui/material';

interface EventTagProps {
    label: string;
}

const EventTag = ({ label }: EventTagProps) => {
    return <Chip label={label} sx={{ fontSize: '0.875rem', color: '#4a4a4a' }} />;
};

export default EventTag;
2. EventDetails Component
Displays the main details of the event, including image, title, tags, date, location, and overview.

components/EventDetails.tsx
import React from 'react';
import { Box, Typography, Button } from '@mui/material';
import EventTag from './EventTag';

interface EventDetailsProps {
    imageSrc: string;
    title: string;
    date: string;
    location: string;
    overview: string;
    tags: string[];
    onJoinClick: () => void;
}

const EventDetails = ({
    imageSrc,
    title,
    date,
    location,
    overview,
    tags,
    onJoinClick,
}: EventDetailsProps) => {
    return (
        <Box sx={{ padding: 2, backgroundColor: '#eff3f4', minHeight: '100vh' }}>
            <img
                src={imageSrc}
                alt={title}
                style={{ width: '100%', height: '200px', borderRadius: '8px', objectFit: 'cover', marginBottom: '16px' }}
            />
            <Typography variant="h6" sx={{ fontWeight: 'bold', mb: 2 }}>
                {title}
            </Typography>
            <Box sx={{ display: 'flex', gap: 1, mb: 3 }}>
                {tags.map((tag, index) => (
                    <EventTag key={index} label={tag} />
                ))}
            </Box>
            <Button
                variant="contained"
                color="primary"
                fullWidth
                sx={{
                    height: '48px',
                    borderRadius: '24px',
                    backgroundColor: '#429AD0',
                    fontWeight: 'bold',
                    mb: 3,
                    '&:hover': { backgroundColor: '#357CA5' },
                }}
                onClick={onJoinClick}
            >
                参加する
            </Button>
            <Typography variant="subtitle1" sx={{ mb: 1 }}>日時</Typography>
            <Typography variant="body2" sx={{ mb: 2 }}>{date}</Typography>
            <Typography variant="subtitle1" sx={{ mb: 1 }}>場所</Typography>
            <Typography variant="body2" sx={{ mb: 2 }}>{location}</Typography>
            <Typography variant="subtitle1" sx={{ mb: 1 }}>イベント概要</Typography>
            <Typography variant="body2">{overview}</Typography>
        </Box>
    );
};

export default EventDetails;
3. JoinEventModal Component
Handles the modal pop-up for the user input form when joining an event.

components/JoinEventModal.tsx
import React, { useState } from 'react';
import { Dialog, DialogTitle, DialogContent, TextField, Button, Box } from '@mui/material';

interface JoinEventModalProps {
    open: boolean;
    onClose: () => void;
    onJoin: (data: { name: string; department: string }) => void;
}

const JoinEventModal = ({ open, onClose, onJoin }: JoinEventModalProps) => {
    const [name, setName] = useState('');
    const [department, setDepartment] = useState('');

    const handleJoinClick = () => {
        if (name.trim() === '' || department.trim() === '') {
            alert('Please fill in all fields.');
            return;
        }

        onJoin({ name, department });
        onClose();
    };

    return (
        <Dialog open={open} onClose={onClose} maxWidth="xs" fullWidth>
            <DialogTitle>イベント参加</DialogTitle>
            <DialogContent>
                <TextField
                    label="名前"
                    placeholder="名前"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    fullWidth
                    sx={{ mb: 2 }}
                />
                <TextField
                    label="所属部署"
                    placeholder="所属部署"
                    value={department}
                    onChange={(e) => setDepartment(e.target.value)}
                    fullWidth
                    sx={{ mb: 3 }}
                />
                <Box sx={{ display: 'flex', justifyContent: 'space-between' }}>
                    <Button variant="contained" color="primary" onClick={handleJoinClick}>
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
4. EventDetailsScreen
The main screen that integrates the EventDetails and JoinEventModal components.

pages/EventDetailsScreen.tsx
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
        overview: '体育館でサッカーの簡単な練習と試合を行います。興味がある方はぜひご参加ください。',
        tags: ['サッカー', '20代', '30代'],
    };

    const handleJoinClick = () => {
        setModalOpen(true);
    };

    const handleCloseModal = () => {
        setModalOpen(false);
    };

    const handleJoinEvent = (data: { name: string; department: string }) => {
        console.log('User joined the event:', data);
    };

    return (
        <>
            <EventDetails {...event} onJoinClick={handleJoinClick} />
            <JoinEventModal open={isModalOpen} onClose={handleCloseModal} onJoin={handleJoinEvent} />
        </>
    );
};

export default EventDetailsScreen;
Summary of Changes
