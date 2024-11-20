We will use the fetchEventParticipants service to dynamically load and display participant data.

tsx
Copy code
import React, { useEffect, useState } from "react";
import { Box, Avatar, Typography, Divider, IconButton } from "@mui/material";
import ArrowBackIosNewIcon from "@mui/icons-material/ArrowBackIosNew";
import { useNavigate, useParams } from "react-router-dom";
import { fetchEventParticipants } from "../services"; // Adjust the path as needed
import { UserInfoTypeFromBackendRes } from "../entities/user"; // Adjust the path as needed

const ParticipantList: React.FC = () => {
    const navigate = useNavigate();
    const { id } = useParams<{ id: string }>(); // Get the event ID from the route
    const [participants, setParticipants] = useState<UserInfoTypeFromBackendRes[]>([]);

    // Fetch participants dynamically
    const onFetchEventParticipants = async () => {
        try {
            const { data } = await fetchEventParticipants(id ?? "1");
            setParticipants(data.filter((info) => info !== null)); // Filter out null values
        } catch (err: any) {
            console.error("Failed to fetch participants:", err);
        }
    };

    useEffect(() => {
        onFetchEventParticipants(); // Fetch participants when component mounts
    }, [id]);

    return (
        <Box sx={{ padding: 2 }}>
            {/* Back Button */}
            <IconButton onClick={() => navigate(-1)} sx={{ mb: 2 }}>
                <ArrowBackIosNewIcon />
            </IconButton>

            <Typography variant="h6" sx={{ mb: 2, fontWeight: "bold" }}>
                参加メンバー
            </Typography>

            {/* List of Participants */}
            {participants.map((participant, index) => (
                <Box key={index} sx={{ display: "flex", alignItems: "center", mb: 2 }}>
                    <Avatar sx={{ width: 40, height: 40, bgcolor: "#3f51b5", mr: 2 }}>
                        {participant.name.charAt(0).toUpperCase()}
                    </Avatar>
                    <Box>
                        <Typography variant="body1" sx={{ fontWeight: 600 }}>
                            {participant.name}
                        </Typography>
                        <Typography variant="body2" sx={{ color: "#6e6e6e" }}>
                            {participant.department}
                        </Typography>
                    </Box>
                </Box>
            ))}

            {/* Divider Line */}
            <Divider sx={{ my: 1 }} />
        </Box>
    );
};

export default ParticipantList;
Key Points in the Code
Fetching Data:

fetchEventParticipants(id ?? "1") fetches the participants for the given id.
Filters out null or invalid values from the API response.
Dynamic Rendering:

Maps through the participants array and displays each participant’s name and department.
Type Safety:

Uses UserInfoTypeFromBackendRes[] to ensure type safety for participant data.
Navigation:

The back button (navigate(-1)) takes the user back to the previous page.
Error Handling:

Logs errors to the console for debugging.
Example Output
When this component is mounted (e.g., when navigating to /EventInfo/:id/participantlist), it will:

Fetch participant data from fetchEventParticipants.
Display a vertically aligned list of participants with:
Their avatar (first letter of the name).
Their name and department.
Enhancements You Can Add
Loading State: Add a loading spinner while fetching participants:

tsx
Copy code
const [loading, setLoading] = useState(false);

const onFetchEventParticipants = async () => {
    setLoading(true);
    try {
        const { data } = await fetchEventParticipants(id ?? "1");
        setParticipants(data.filter((info) => info !== null));
    } catch (err: any) {
        console.error("Failed to fetch participants:", err);
    } finally {
        setLoading(false);
    }
};
Render a loader when loading is true:

tsx
Copy code
{loading ? <Typography>Loading...</Typography> : /* Participants List */}
No Participants Message: Display a message if no participants are found:

tsx
Copy code
{participants.length === 0 ? (
    <Typography>No participants found.</Typography>
) : (
    participants.map((participant) => /* Participant List */)
)}
Error Message: Show an error message if the API call fails.

Expected Integration Workflow
