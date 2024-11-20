Update the Type of participantNameList: In the useEventInfo hook or wherever participantNameList is defined, change its type to:

tsx
Copy code
const [participantNameList, setParticipantNameList] = useState<{ name: string; department?: string }[]>([]);
Here:

Each element in participantNameList is now an object with a name property (string) and an optional department property (string).
Update Data Fetching Logic: When you fetch data and set participantNameList, ensure the structure matches the updated type:

tsx
Copy code
const onFetchEventParticipants = async () => {
    try {
        const { data } = await fetchEventParticipants(id ?? "1");
        setParticipantNameList(
            data
                .filter((info) => info !== null)
                .map(({ name, department }: { name: string; department?: string }) => ({
                    name,
                    department,
                }))
        );
    } catch (err: any) {
        console.error("Failed to fetch participants:", err);
    }
};
Refactor the Rendering Logic
Now that participantNameList contains objects with name and department, you can safely access these properties when rendering.

Update your rendering logic as follows:

tsx
Copy code
{participantNameList.map((participant, index) => (
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
))}
Summary of Changes
Type Update:

Changed participantNameList type to Array<{ name: string; department?: string }>.
Data Fetching:

Ensure the fetched data is mapped into objects with name and department.
Rendering:

Access name and department properties in the rendering logic.
Full Example
Here’s the updated ParticipantListScreen:

tsx
Copy code
import React, { useEffect } from "react";
import { Box, Avatar, Typography, Divider, IconButton } from "@mui/material";
import ArrowBackIosNewIcon from "@mui/icons-material/ArrowBackIosNew";
import CloseIcon from "@mui/icons-material/Close";
import { useNavigate } from "react-router-dom";
import { useEventInfo } from "../hooks/useEventInfo";

const ParticipantListScreen: React.FC = () => {
    const navigate = useNavigate();
    const { participantNameList, onFetchEventParticipants } = useEventInfo();

    useEffect(() => {
        if (!participantNameList.length) {
            onFetchEventParticipants();
        }
    }, [participantNameList, onFetchEventParticipants]);

    return (
        <Box sx={{ padding: 2 }}>
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

            <Divider sx={{ my: 1 }} />
        </Box>
    );
};

export default ParticipantListScr;
