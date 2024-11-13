import React from 'react';
import { Card, CardContent, Typography, Box } from '@mui/material';

interface EventCardProps {
    imageSrc: string;
    title: string;
    date: string;
    description: string;
    onClick: () => void;
}

const EventCard = ({ imageSrc, title, date, description, onClick }: EventCardProps) => {
    return (
        <Card sx={{ display: 'flex', mb: 2 }} onClick={onClick}>
            <img src={imageSrc} alt={title} style={{ width: 100, height: 100, objectFit: 'cover' }} />
            <CardContent>
                <Typography variant="h6">{title}</Typography>
                <Typography variant="body2" color="textSecondary">{date}</Typography>
                <Typography variant="body2">{description}</Typography>
            </CardContent>
        </Card>
    );
};

export default EventCard;

import React from 'react';
import { Typography, Button, Box } from '@mui/material';

interface EmptyStateProps {
    message: string;
    onAddEvent: () => void;
}

const EmptyState = ({ message, onAddEvent }: EmptyStateProps) => {
    return (
        <Box textAlign="center" sx={{ mt: 4 }}>
            <Typography variant="body1" color="textSecondary">{message}</Typography>
            <Button variant="outlined" onClick={onAddEvent} sx={{ mt: 2 }}>
                イベントを追加する
            </Button>
        </Box>
    );
};

export default EmptyState;

import React from 'react';
import { Box, Typography, Button, Chip } from '@mui/material';

interface EventDetailsProps {
    imageSrc: string;
    title: string;
    date: string;
    location: string;
    overview: string;
    tags: string[];
    onJoin: () => void;
}

const EventDetails = ({ imageSrc, title, date, location, overview, tags, onJoin }: EventDetailsProps) => {
    return (
        <Box sx={{ padding: 2 }}>
            <img src={imageSrc} alt={title} style={{ width: '100%', borderRadius: 8, marginBottom: 16 }} />
            <Typography variant="h6">{title}</Typography>
            <Box sx={{ display: 'flex', gap: 1, mt: 1 }}>
                {tags.map((tag, index) => (
                    <Chip key={index} label={tag} />
                ))}
            </Box>
            <Button variant="contained" color="primary" fullWidth sx={{ mt: 2 }} onClick={onJoin}>
                参加する
            </Button>
            <Typography variant="subtitle1" sx={{ mt: 3 }}>日時</Typography>
            <Typography variant="body2">{date}</Typography>
            <Typography variant="subtitle1" sx={{ mt: 3 }}>場所</Typography>
            <Typography variant="body2">{location}</Typography>
            <Typography variant="subtitle1" sx={{ mt: 3 }}>イベント概要</Typography>
            <Typography variant="body2">{overview}</Typography>
        </Box>
    );
};

export default EventDetails;

import React, { useState } from 'react';
import { Box, Button } from '@mui/material';
import EventCard from '../components/EventCard';
import EmptyState from '../components/EmptyState';

const EventList = () => {
    const [events, setEvents] = useState([
        {
            imageSrc: '/images/soccer.jpg',
            title: 'サッカーの練習 & 試合',
            date: '2024/11/22',
            description: 'スポーツを楽しむイベントです。',
        },
        {
            imageSrc: '/images/soccer.jpg',
            title: 'サッカー観戦',
            date: '2024/12/24',
            description: 'みんなでサッカーを観戦しましょう。',
        },
    ]);

    const handleAddEvent = () => {
        console.log('Add Event Clicked');
    };

    const handleEventClick = () => {
        console.log('Event Clicked');
    };

    return (
        <Box sx={{ padding: 2 }}>
            <Button variant="outlined" fullWidth sx={{ mb: 2 }} onClick={handleAddEvent}>
                イベントを追加する
            </Button>

            {events.length > 0 ? (
                events.map((event, index) => (
                    <EventCard key={index} {...event} onClick={handleEventClick} />
                ))
            ) : (
                <EmptyState message="イベントが登録されていません" onAddEvent={handleAddEvent} />
            )}
        </Box>
    );
};

export default EventList;

import React from 'react';
import EventDetails from '../components/EventDetails';

const EventDetailsScreen = () => {
    const event = {
        imageSrc: '/images/soccer.jpg',
        title: 'サッカーの練習 & 試合',
        date: '2024/11/22',
        location: '大田区総合体育館',
        overview: '体育館でサッカーの簡単な練習と試合を行います。興味がある方はぜひご参加ください。',
        tags: ['サッカー', '20代', '30代'],
    };

    const handleJoin = () => {
        console.log('Join Event Clicked');
    };

    return <EventDetails {...event} onJoin={handleJoin} />;
};

export default EventDetailsScreen;

