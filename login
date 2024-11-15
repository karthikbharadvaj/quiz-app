1. Updated EventDetailContainer.tsx
typescript
Copy code
import React, { useState } from 'react';
import { Box, Typography, Button, Chip } from '@mui/material';
import TagAdd from './TagAdd';

interface EventDetailContainerProps {
    imageSrc: string;
    title: string;
    date: string;
    location: string;
    overview: string;
    tags: string[];
    onJoinClick: () => void;
}

const EventDetailContainer = ({
    imageSrc,
    title,
    date,
    location,
    overview,
    tags,
    onJoinClick,
}: EventDetailContainerProps) => {
    const [eventTags, setEventTags] = useState<string[]>(tags);

    const handleTagUpdate = (updatedTags: string[]) => {
        setEventTags(updatedTags);
    };

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
                {eventTags.map((tag, index) => (
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

            <TagAdd
                title="タグを追加"
                name="eventTags"
                handler={handleTagUpdate}
                recommendedTags={['サッカー', '20代', '30代']}
                isOnlyTagRecommend={false}
            />
        </Box>
    );
};

export default EventDetailContainer;
2. Updated JoinEventContainer.tsx
typescript
Copy code
import React from 'react';
import { Dialog, DialogTitle, DialogContent, TextField, Button, Box } from '@mui/material';

interface JoinEventContainerProps {
    open: boolean;
    onClose: () => void;
}

const JoinEventContainer = ({ open, onClose }: JoinEventContainerProps) => {
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

export default JoinEventContainer;
3. Updated EventDetailScreen.tsx
typescript
Copy code
import React, { useState } from 'react';
import EventDetailContainer from '../components/EventDetailContainer';
import JoinEventContainer from '../components/JoinEventContainer';

const EventDetailScreen = () => {
    const [isModalOpen, setModalOpen] = useState(false);

    const event = {
        imageSrc: '/images/soccer.jpg',
        title: 'サッカーの練習 & 試合',
        date: '2024/11/22',
        location: '大田区総合体育館',
        overview: '体育館でサッカーの簡単な練習と試合を行います。興味がある方はぜひご参加ください。',
        tags: ['サッカー', 'スポーツ'],
    };

    const handleJoinClick = () => {
        setModalOpen(true);
    };

    const handleCloseModal = () => {
        setModalOpen(false);
    };

    return (
        <>
            <EventDetailContainer
                imageSrc={event.imageSrc}
                title={event.title}
                date={event.date}
                location={event.location}
                overview={event.overview}
                tags={event.tags}
                onJoinClick={handleJoinClick}
            />
            <JoinEventContainer open={isModalOpen} onClose={handleCloseModal} />
        </>
    );
};

export default EventDetailScreen;
Summary
