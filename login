1. Update the Present Page (EventInfo)
In your EventInfo page, add the forward arrow and configure navigation to the ParticipantList page.

tsx
Copy code
import React from "react";
import { useNavigate, useParams } from "react-router-dom";
import { Box, Typography, IconButton, Avatar } from "@mui/material";
import ArrowForwardIosIcon from "@mui/icons-material/ArrowForwardIos";

const EventInfo: React.FC = () => {
    const { id } = useParams<{ id: string }>(); // Get the event ID from the URL
    const navigate = useNavigate();

    const handleNavigate = () => {
        navigate(`/participants/${id}`); // Navigate to the participants list with the event ID
    };

    return (
        <Box sx={{ padding: 2 }}>
            {/* Event Info */}
            <Typography variant="h5" sx={{ fontWeight: 700, mb: 2 }}>
                イベント情報
            </Typography>

            {/* Participants Section */}
            <Box sx={{ display: "flex", alignItems: "center", justifyContent: "space-between", mb: 2 }}>
                <Box sx={{ display: "flex", gap: 0.5 }}>
                    {["A", "B", "C", "D", "E"].map((name, index) => (
                        <Avatar key={index} sx={{ bgcolor: "#3f51b5" }}>
                            {name}
                        </Avatar>
                    ))}
                </Box>
                <IconButton onClick={handleNavigate}>
                    <ArrowForwardIosIcon />
                </IconButton>
            </Box>
        </Box>
    );
};

export default EventInfo;
2. Add the ParticipantList Page
This page fetches participants based on the event ID passed through the URL.

tsx
Copy code
import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { Box, Avatar, Typography, IconButton } from "@mui/material";
import CloseIcon from "@mui/icons-material/Close";

interface Participant {
    name: string;
    department: string;
}

const ParticipantList: React.FC = () => {
    const { id } = useParams<{ id: string }>(); // Get the event ID from the URL
    const navigate = useNavigate();
    const [participants, setParticipants] = useState<Participant[]>([]);

    useEffect(() => {
        // Fetch participants from API
        const fetchParticipants = async () => {
            try {
                const response = await fetch(`/api/EventInfo/${id}/participants`); // Replace with your backend API
                const data = await response.json();
                setParticipants(data);
            } catch (error) {
                console.error("Error fetching participants:", error);
            }
        };

        fetchParticipants();
    }, [id]);

    const handleBack = () => {
        navigate(-1); // Navigate back to the EventInfo page
    };

    return (
        <Box sx={{ padding: 2 }}>
            {/* Header */}
            <Box sx={{ display: "flex", justifyContent: "space-between", alignItems: "center", mb: 2 }}>
                <Typography variant="h6" sx={{ fontWeight: 700 }}>
                    参加メンバー
                </Typography>
                <IconButton onClick={handleBack}>
                    <CloseIcon />
                </IconButton>
            </Box>

            {/* Participants List */}
            <Box>
                {participants.map((participant, index) => (
                    <Box
                        key={index}
                        sx={{
                            display: "flex",
                            alignItems: "center",
                            padding: 1,
                            borderBottom: "1px solid #e0e0e0",
                        }}
                    >
                        <Avatar sx={{ marginRight: 2, bgcolor: "#3f51b5" }}>
                            {participant.name.charAt(0).toUpperCase()}
                        </Avatar>
                        <Box>
                            <Typography variant="body1" sx={{ fontWeight: 700 }}>
                                {participant.name}
                            </Typography>
                            <Typography variant="body2" sx={{ color: "#757575" }}>
                                {participant.department}
                            </Typography>
                        </Box>
                    </Box>
                ))}
            </Box>
        </Box>
    );
};

export default ParticipantList;
3. Routing Setup
Add routes for both EventInfo and ParticipantList in your app's routing configuration.

tsx
Copy code
import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import EventInfo from "./pages/EventInfo";
import ParticipantList from "./pages/ParticipantList";

const App: React.FC = () => {
    return (
        <Router>
            <Routes>
                <Route path="/eventinfo/:id" element={<EventInfo />} />
                <Route path="/participants/:id" element={<ParticipantList />} />
            </Routes>
        </Router>
    );
};

export default App;
Backend API for Participants
Ensure your backend API provides participant data based on the event ID.

typescript
Copy code
router.get("/api/EventInfo/:id/participants", async (req, res) => {
    const { id } = req.params;

    try {
        const participants = await getEventParticipantsUseCase.getEventParticipants({ id });
        res.json(participants);
    } catch (error) {
        console.error("Error fetching participants:", error);
        res.status(500).json({ error: "Failed to fetch participants" });
    }
});
Final Workflow
