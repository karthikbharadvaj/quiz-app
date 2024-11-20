
To include both the name and department in the ParticipantsBox component (similar to what you have displayed), we can modify the map function to include additional details. Here's how the code will look:

Updated ParticipantsBox
tsx
Copy code
import React from 'react';
import { Box, Avatar, Typography, Divider, IconButton } from '@mui/material';
import ArrowForwardIosIcon from '@mui/icons-material/ArrowForwardIos';
import { useNavigate } from 'react-router-dom';

interface Participant {
    name: string;
    department: string;
}

interface ParticipantsBoxProps {
    participants: Participant[];
}

const ParticipantsBox: React.FC<ParticipantsBoxProps> = ({ participants }) => {
    const navigate = useNavigate();

    const onClickForward = () => {
        navigate('/EventInfo/30/participants'); // Update route dynamically
    };

    return (
        <Box sx={{ width: '100%', flexDirection: 'column', display: 'flex', justifyContent: 'space-between' }}>
            <Typography variant="body1" sx={{ fontWeight: 700, mb: 1 }}>
                メンバー
            </Typography>
            <Box
                sx={{
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    flex: 1,
                    position: 'relative',
                    gap: 0.5,
                }}
            >
                {participants.slice(0, 5).map((participant, index) => (
                    <Box key={index} sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center', mr: 2 }}>
                        <Avatar
                            sx={{
                                width: 32,
                                height: 32,
                                bgcolor: '#73C6C8',
                                color: '#fff',
                                fontSize: '14',
                            }}
                        >
                            {participant.name.charAt(0).toUpperCase()}
                        </Avatar>
                        <Typography variant="body2" sx={{ mt: 1, textAlign: 'center' }}>
                            {participant.name}
                        </Typography>
                        <Typography variant="body2" sx={{ color: '#6e6e6e', textAlign: 'center' }}>
                            {participant.department}
                        </Typography>
                    </Box>
                ))}
            </Box>
            <IconButton onClick={onClickForward} sx={{ position: 'absolute', right: '0' }}>
                <ArrowForwardIosIcon />
            </IconButton>
            <Divider sx={{ my: 2 }} />
        </Box>
    );
};

export default ParticipantsBox;
