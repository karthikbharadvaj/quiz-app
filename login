import React from 'react';
import { Box } from '@mui/material';

interface PaginationDotsProps {
    activeIndex: number;
    total: number;
}

const PaginationDots: React.FC<PaginationDotsProps> = ({ activeIndex, total }) => {
    return (
        <Box display="flex" justifyContent="center" mt={2}>
            {Array.from({ length: total }).map((_, index) => (
                <Box
                    key={index}
                    sx={{
                        width: 8,
                        height: 8,
                        borderRadius: '50%',
                        backgroundColor: index === activeIndex ? '#429AD0' : '#c4c4c4',
                        margin: '0 4px',
                    }}
                />
            ))}
        </Box>
    );
};

export default PaginationDots;
