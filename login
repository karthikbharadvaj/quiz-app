import React, { useEffect } from "react";
import { Box, Avatar, Typography, Divider, IconButton } from "@mui/material";
import ArrowBackIosNewIcon from "@mui/icons-material/ArrowBackIosNew";
import CloseIcon from "@mui/icons-material/Close";
import { useNavigate } from "react-router-dom";
import { useEventInfo } from "../hooks/useEventInfo"; // Adjust the path as needed

const ParticipantListScreen: React.FC = () => {
    const navigate = useNavigate();

    // Reuse the custom hook
    const { participantNameList, onFetchEventParticipants } = useEventInfo();

    // Fetch participants if not already available
    useEffect(() => {
        if (!participantNameList.length) {
            onFetchEventParticipants(); // Fetch participants if the list is empty
        }
    }, [participantNameList, onFetchEventParticipants]);

    return (
        <Box sx={{ padding: 2 }}>
            {/* Back Button and Title */}
            <Box sx={{ display: "flex", justifyContent: "space-between", alignItems: "center", mb: 2 }}>
                <IconButton onClick={() => navigate(-1)}>
                    <ArrowBackIosNewIcon />
                </IconButton>
                <Typography variant="h6" sx={{ fontWeight: "bold", textAlign: "center", flex: 1 }}>
                    参加メンバー
                </Typography>
                <IconButton onClick={() => navigate("/")}>
                    <CloseIcon />
                </IconButton>
            </Box>

            {/* Conditional Rendering for Participants */}
            {participantNameList.length === 0 ? (
                // Display message when no participants are available
                <Typography sx={{ textAlign: "center", mt: 4, fontSize: 16, color: "#6e6e6e" }}>
                    No participants found
                </Typography>
            ) : (
                // Render participants when list is available
                participantNameList.map((participant, index) => (
                    <Box key={index} sx={{ display: "flex", alignItems: "center", mb: 2 }}>
                        <Avatar sx={{ width: 40, height: 40, bgcolor: "#3f51b5", mr: 2 }}>
                            {participant.name.charAt(0).toUpperCase()}
                        </Avatar>
                        <Box>
                            <Typography variant="body1" sx={{ fontWeight: 600 }}>
                                {participant.name}
                            </Typography>
                            <Typography variant="body2" sx={{ color: "#6e6e6e" }}>
                                {participant.department || "No department"}
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
