Step 1: Define the Interface
Define the interface for the props of ParticipantsBox.

typescript
Copy code
interface ParticipantsBoxProps {
    participants: string[];
}
Step 2: Create the ParticipantsBox Component
Below is the implementation of ParticipantsBox, following a similar structure to your ContentsBox component.

tsx
Copy code
import React from "react";
import { Box, Typography, Avatar, Divider } from "@mui/material";

const ParticipantsBox: React.FC<ParticipantsBoxProps> = ({ participants }) => {
    return (
        <Box sx={{ width: "100%", flexDirection: "column", display: "flex" }}>
            {participants.length > 0 ? (
                participants.map((name, index) => (
                    <Box key={index} sx={{ display: "flex", alignItems: "center", mb: 2 }}>
                        <Avatar sx={{ width: 40, height: 40, bgcolor: "#3f51b5", mr: 2 }}>
                            {name.charAt(0).toUpperCase()}
                        </Avatar>
                        <Typography
                            sx={{ fontWeight: 700, wordWrap: "break-word", color: "#454545" }}
                        >
                            {name}
                        </Typography>
                    </Box>
                ))
            ) : (
                <Typography sx={{ color: "#454545" }}>参加者がいません</Typography>
            )}
            <Divider sx={{ my: 2 }} />
        </Box>
    );
};

export default ParticipantsBox;
Explanation
Layout:

The Box component is used to structure the layout in a column, similar to ContentsBox.
Avatar is used to display the first letter of the participant's name, adding a visual representation.
Mapping Through Participants:

The participants.map() function iterates through the list of participant names.
Each participant's name is displayed with an Avatar and Typography element.
Fallback Message:

If the participants list is empty, it shows "参加者がいません".
Styling:

The styles match your current approach, using sx for inline styling and colors consistent with your design.
Step 3: Using ParticipantsBox in Your Main Component
Import and use ParticipantsBox in your main component:

tsx
Copy code
import ParticipantsBox from "./components/ParticipantsBox";

<Box sx={{ mt: 3 }}>
    <Typography variant="h6">参加者リスト</Typography>
    <ParticipantsBox participants={participantNameList} />
</Box>
Step 4: Ensure participantNameList is Set Correctly
Make sure your participantNameList state is updated correctly via your custom hook:

typescript
Copy code
useEffect(() => {
    onFetchEventParticipants();
}, []);
Final Notes
