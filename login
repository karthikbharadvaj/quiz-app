Code Implementation
tsx
Copy code
import React, { useState } from "react";
import { Box, Button, Typography, IconButton } from "@mui/material";
import EditIcon from "@mui/icons-material/Edit";

const EventAction = () => {
  // State to manage "参加予定" status
  const [isParticipating, setIsParticipating] = useState(false);

  // Handler to toggle participation state
  const handleParticipation = () => {
    setIsParticipating((prev) => !prev);
  };

  return (
    <Box
      sx={{
        display: "flex",
        alignItems: "center",
        gap: 1,
        flexDirection: "row",
      }}
    >
      {/* Orange Circle */}
      <Button
        variant="contained"
        onClick={handleParticipation}
        sx={{
          backgroundColor: isParticipating ? "#FFA500" : "#D3D3D3", // Orange if participating
          color: "#fff",
          borderRadius: "20px",
          padding: "5px 15px",
          textTransform: "none",
          fontSize: "14px",
          boxShadow: "none",
          ":hover": {
            backgroundColor: isParticipating ? "#FF8C00" : "#C0C0C0", // Slightly darker on hover
          },
        }}
      >
        {isParticipating ? "参加予定" : "参加キャンセル"}
      </Button>

      {/* Edit Icon */}
      <IconButton
        sx={{
          backgroundColor: "#f0f0f0",
          borderRadius: "50%",
          padding: "5px",
          ":hover": {
            backgroundColor: "#e0e0e0",
          },
        }}
        onClick={() => console.log("Edit button clicked")}
      >
        <EditIcon fontSize="small" />
      </IconButton>
    </Box>
  );
};

export default EventAction;
Key Features
Orange Circle Button (参加予定):

The button's background color changes based on the isParticipating state.
Clicking the button toggles the isParticipating state.
Edit Button:

Displays an edit icon.
Logs a message to the console when clicked (can later be replaced with actual functionality).
Styling
Orange Button:

Rounded (borderRadius: "20px").
Dynamic background color based on state.
Edit Button:

Circular, with a hover effect.
Usage
Import and use this component wherever needed:

tsx
Copy code
import EventAction from "./EventAction";

const App = () => {
  return (
    <div>
      <h1>Event Details</h1>
      <EventAction />
    </div>
  );
};

export default App;
Output
