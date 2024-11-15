EventDetails Component
We will integrate TagAdd into the EventDetails component, allowing users to add tags for the event.

EventDetails.tsx
typescript
Copy code
import React, { useState } from 'react';
import { Box, Typography, Button, Chip } from '@mui/material';
import TagAdd from './TagAdd';

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
    const [eventTags, setEventTags] = useState<string[]>(tags);

    const handleTagUpdate = (updatedTags: string[]) => {
        setEventTags(updatedTags);
        console.log('Updated Tags:', updatedTags);
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
            <Typography variant="body2" sx={{ marginBottom: '16px' }}>
                {overview}
            </Typography>

            {/* Integrate TagAdd Component */}
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

export default EventDetails;
3. EventDetailsScreen Component
This screen will include the EventDetails component and handle the state for the modal pop-up when the user clicks the 参加する (Join) button.

EventDetailsScreen.tsx
typescript
Copy code
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
