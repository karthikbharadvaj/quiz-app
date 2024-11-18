Step 1: Modify onFetchEventParticipants Function
Ensure your handler fetches and updates the participant list correctly.

typescript
Copy code
const onFetchEventParticipants = async () => {
    try {
        const { data } = await fetchEventParticipants(id ?? '1');
        // Extract names from the fetched participant data
        const participantNames = data
            .filter((info) => info !== null)
            .map(({ name }) => name);

        setParticipantNameList(participantNames);
    } catch (err: any) {
        console.error('Update error', err);
    }
};
Step 2: Create the Participant List Component
Create a new component to display the participants.

tsx
Copy code
// src/components/ParticipantsList.tsx
import React from "react";
import { Box, Typography, Avatar } from "@mui/material";

interface ParticipantsListProps {
    participantNames: string[];
}

const ParticipantsList: React.FC<ParticipantsListProps> = ({ participantNames }) => {
    return (
        <Box sx={{ display: "flex", gap: 2, flexWrap: "wrap", marginTop: 2 }}>
            {participantNames.map((name, index) => (
                <Box key={index} sx={{ textAlign: "center" }}>
                    <Avatar sx={{ width: 40, height: 40 }}>
                        {name.charAt(0).toUpperCase()}
                    </Avatar>
                    <Typography variant="body2">{name}</Typography>
                </Box>
            ))}
        </Box>
    );
};

export default ParticipantsList;
Step 3: Integrate the Component in Your Main Page
Import and use this component in your main page (where onFetchEventParticipants is used).

tsx
Copy code
import React, { useEffect, useState } from "react";
import { ParticipantsList } from "./components/ParticipantsList";

const EventInfoPage: React.FC = () => {
    const [participantNameList, setParticipantNameList] = useState<string[]>([]);

    useEffect(() => {
        onFetchEventParticipants();
    }, []);

    return (
        <div>
            <h2>Event Participants</h2>
            <ParticipantsList participantNames={participantNameList} />
        </div>
    );
};

export default EventInfoPage;
