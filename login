Here's the updated implementation:

tsx
Copy code
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

            {/* List of Participants */}
            {participantNameList.length === 0 ? (
                <Typography sx={{ textAlign: "center", mt: 2 }}>No participants found</Typography>
            ) : (
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
Key Changes and Fixes
Correct URL Handling:

The URL issue occurs when the id is not passed correctly. This is handled in useEventInfo where the API call is made. Make sure the id is properly fetched using useParams in the useEventInfo hook.
Reuse of useEventInfo:

Instead of duplicating the logic for fetching participants, the custom hook useEventInfo is used in both EventInfoPage and ParticipantListScreen.
Conditional Fetching:

The participantNameList is fetched only if it's not already populated, preventing unnecessary API calls.
Rendering Participants:

Ensures the list of participants is rendered with name and department. If the department is missing, a fallback value ("No department") is displayed.
Navigation Buttons:

The back button navigates to the previous page (navigate(-1)).
The close button navigates to the home page (navigate("/")).
Fixing the URL Issue in useEventInfo
Ensure that the API call in useEventInfo correctly interpolates the id:

tsx
Copy code
const onFetchEventParticipants = async () => {
    try {
        const { data } = await fetchEventParticipants(id ?? "1"); // Ensure `id` is correctly passed
        setParticipantNameList(
            data.map(({ name, department }: { name: string; department: string }) => ({
                name,
                department,
            }))
        );
    } catch (err: any) {
        console.error("Failed to fetch participants:", err);
    }
};
Ensure id is obtained using useParams and is available in useEventInfo:

tsx
Copy code
import { useParams } from "react-router-dom";

const { id } = useParams<{ id: string }>();
Summary
