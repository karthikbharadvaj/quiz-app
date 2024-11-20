2. Custom Hook (useEventInfo)
This hook handles fetching participants and other event-related data.

tsx
Copy code
import { useState } from "react";
import { fetchEventParticipants } from "../services/eventService";

export const useEventInfo = (id: string) => {
  const [participantNameList, setParticipantNameList] = useState<{ name: string; department: string }[]>([]);

  const onFetchEventParticipants = async () => {
    try {
      const participants = await fetchEventParticipants(id);
      setParticipantNameList(participants);
    } catch (err: any) {
      console.error("Error fetching participants:", err);
    }
  };

  return {
    participantNameList,
    onFetchEventParticipants,
  };
};
3. ParticipantsBox Component
This displays participant avatars, names, and departments with a forward arrow for navigation.

tsx
Copy code
import React from "react";
import { Box, Avatar, Typography, IconButton } from "@mui/material";
import ArrowForwardIosIcon from "@mui/icons-material/ArrowForwardIos";
import { useNavigate } from "react-router-dom";

interface ParticipantsBoxProps {
  participants: { name: string; department: string }[];
  onNavigate: () => void; // Navigation callback for the forward arrow
}

const ParticipantsBox: React.FC<ParticipantsBoxProps> = ({ participants, onNavigate }) => {
  return (
    <Box sx={{ width: "100%", flexDirection: "column", display: "flex" }}>
      <Typography variant="body1" sx={{ fontWeight: 700, mb: 1 }}>
        メンバー
      </Typography>

      <Box
        sx={{
          display: "flex",
          alignItems: "center",
          justifyContent: "space-between",
        }}
      >
        <Box sx={{ display: "flex", alignItems: "center", gap: 2 }}>
          {participants.slice(0, 5).map(({ name, department }, index) => (
            <Box
              key={index}
              sx={{
                display: "flex",
                alignItems: "center",
                gap: 2,
              }}
            >
              <Avatar
                sx={{
                  width: 32,
                  height: 32,
                  bgcolor: "#73C6C8",
                  color: "#fff",
                  fontSize: "14px",
                }}
              >
                {name.charAt(0).toUpperCase()}
              </Avatar>
              <Box>
                <Typography variant="body1" sx={{ fontWeight: "bold" }}>
                  {name}
                </Typography>
                <Typography variant="body2" sx={{ color: "#6e6e6e" }}>
                  {department}
                </Typography>
              </Box>
            </Box>
          ))}
        </Box>
        <IconButton onClick={onNavigate}>
          <ArrowForwardIosIcon />
        </IconButton>
      </Box>
    </Box>
  );
};

export default ParticipantsBox;
4. ParticipantListScreen Component
This displays the full list of participants.

tsx
Copy code
import React, { useEffect } from "react";
import { Box, Avatar, Typography } from "@mui/material";
import { useParams } from "react-router-dom";
import { useEventInfo } from "../hooks/useEventInfo";

const ParticipantListScreen: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const { participantNameList, onFetchEventParticipants } = useEventInfo(id ?? "");

  useEffect(() => {
    onFetchEventParticipants();
  }, [onFetchEventParticipants]);

  return (
    <Box sx={{ padding: 2 }}>
      <Typography variant="h6" sx={{ fontWeight: "bold", mb: 2 }}>
        参加メンバー
      </Typography>
      {participantNameList.map(({ name, department }, index) => (
        <Box
          key={index}
          sx={{
            display: "flex",
            alignItems: "center",
            gap: 2,
            mb: 2,
          }}
        >
          <Avatar
            sx={{
              width: 40,
              height: 40,
              bgcolor: "#3f51b5",
              color: "#fff",
            }}
          >
            {name.charAt(0).toUpperCase()}
          </Avatar>
          <Box>
            <Typography variant="body1" sx={{ fontWeight: "bold" }}>
              {name}
            </Typography>
            <Typography variant="body2" sx={{ color: "#6e6e6e" }}>
              {department}
            </Typography>
          </Box>
        </Box>
      ))}
    </Box>
  );
};

export default ParticipantListScreen;
5. Router Setup
Update the routes in your App.tsx or equivalent file to include both the ParticipantsBox and ParticipantListScreen.

tsx
Copy code
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import ParticipantsBox from "./components/ParticipantsBox";
import ParticipantListScreen from "./components/ParticipantListScreen";

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/EventInfo/:id" element={<ParticipantsBox participants={[]} onNavigate={() => {}} />} />
        <Route path="/EventInfo/:id/participants" element={<ParticipantListScreen />} />
      </Routes>
    </Router>
  );
}

export default App;
Summary of Features
