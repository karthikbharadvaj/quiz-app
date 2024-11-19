Updated Code
1. Update Forward Button in ParticipantsBox
Update the forward button in ParticipantsBox to navigate to the new page.

tsx
Copy code
import React from "react";
import { useNavigate } from "react-router-dom";

// Pass the participants list to the next screen via route state or API
const handleNavigate = () => {
    navigate("/participants", { state: { participants } }); // Passing participants as route state
};
2. Create ParticipantsScreen Component
Create a new component for the participants' list.

tsx
Copy code
import React from "react";
import { Box, Avatar, Typography, IconButton } from "@mui/material";
import { useLocation, useNavigate } from "react-router-dom";
import CloseIcon from "@mui/icons-material/Close";

interface Participant {
    name: string;
    department: string;
}

const ParticipantsScreen: React.FC = () => {
    const navigate = useNavigate();
    const location = useLocation();
    const participants: Participant[] = location.state?.participants || [];

    const handleBack = () => {
        navigate(-1); // Go back to the previous page
    };

    return (
        <Box sx={{ padding: 2 }}>
            {/* Header */}
            <Box sx={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                <IconButton onClick={handleBack}>
                    <CloseIcon />
                </IconButton>
                <Typography variant="h6" sx={{ fontWeight: 700 }}>
                    参加メンバー
                </Typography>
            </Box>

            {/* Participant List */}
            <Box sx={{ marginTop: 2 }}>
                {participants.map((participant, index) => (
                    <Box
                        key={index}
                        sx={{
                            display: "flex",
                            alignItems: "center",
                            marginBottom: 2,
                            paddingBottom: 1,
                            borderBottom: "1px solid #e0e0e0",
                        }}
                    >
                        {/* Avatar */}
                        <Avatar
                            sx={{ width: 40, height: 40, marginRight: 2, bgcolor: "#3f51b5" }}
                        >
                            {participant.name.charAt(0).toUpperCase()}
                        </Avatar>

                        {/* Name and Department */}
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

export default ParticipantsScreen;
3. Add Route for the New Screen
Make sure the route for the new screen is set up in your App or routing configuration.

tsx
Copy code
import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import ParticipantsBox from "./components/ParticipantsBox";
import ParticipantsScreen from "./components/ParticipantsScreen";

const App: React.FC = () => {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<ParticipantsBox />} />
                <Route path="/participants" element={<ParticipantsScreen />} />
            </Routes>
        </Router>
    );
};

export default App;
4. Sample Data Structure for Participants
Pass the participants as a prop or via route state.

typescript
Copy code
const participants = [
    { name: "総研 花子", department: "DXシステム本部" },
    { name: "山田 太郎", department: "営業部" },
    { name: "田中 一郎", department: "技術部" },
    // Add more participants as needed
];
Design Adjustments
