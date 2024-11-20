To maintain consistency and leverage the existing custom hook useEventInfo, we can reuse it in the new ParticipantListScreen as well. Here's how you can implement it.

Updated ParticipantListScreen
tsx
Copy code
import React, { useEffect } from "react";
import { Box, Avatar, Typography, Divider, IconButton } from "@mui/material";
import ArrowBackIosNewIcon from "@mui/icons-material/ArrowBackIosNew";
import { useNavigate } from "react-router-dom";
import { useEventInfo } from "../hooks/useEventInfo"; // Import the custom hook

const ParticipantListScreen: React.FC = () => {
    const navigate = useNavigate();

    // Reuse the custom hook
    const {
        participantNameList, // Already fetched in EventInfo
        onFetchEventParticipants, // In case we need to fetch again
    } = useEventInfo();

    // Optional: Fetch participants again when the screen mounts (not necessary if already loaded)
    useEffect(() => {
        if (!participantNameList.length) {
            onFetchEventParticipants();
        }
    }, []);

    return (
        <Box sx={{ padding: 2 }}>
            {/* Back Button and Title */}
            <Box sx={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                <IconButton onClick={() => navigate(-1)}>
                    <ArrowBackIosNewIcon />
                </IconButton>
                <Typography variant="h6" sx={{ fontWeight: "bold", textAlign: "center", flex: 1 }}>
                    参加メンバー
                </Typography>
                <IconButton onClick={() => navigate("/")}>
                    <Typography variant="body1" sx={{ fontWeight: "bold" }}>
                        ×
                    </Typography>
                </IconButton>
            </Box>

            {/* List of Participants */}
            {participantNameList.length === 0 ? (
                <Typography sx={{ textAlign: "center", mt: 2 }}>No participants found</Typography>
            ) : (
                participantNameList.map((participant, index) => (
                    <Box key={index} sx={{ display: "flex", alignItems: "center", mb: 2 }}>
                        <Avatar sx={{ width: 40, height: 40, bgcolor: "#3f51b5", mr: 2 }}>
                            {participant.charAt(0).toUpperCase()}
                        </Avatar>
                        <Box>
                            <Typography variant="body1" sx={{ fontWeight: 600 }}>
                                {participant}
                            </Typography>
                            <Typography variant="body2" sx={{ color: "#6e6e6e" }}>
                                Department Name (Replace or Fetch if Needed)
                            </Typography>
                        </Box>
                    </Box>
                ))
            )}

            {/* Divider Line */}
            <Divider sx={{ my: 1 }} />
        </Box>
    );
};

export default ParticipantListScreen;
Key Points in the Implementation
