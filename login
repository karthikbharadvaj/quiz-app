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
The "参加予定" button toggles between two states ("参加予定" and "参加キャンセル").
The edit button logs a message to the console when clicked.
Let me know if you need any additional customizations!






You said:
It's not a button, just a circle and it should be always orange and be displayed. Handle to be displayed for false now no need edit button.

2/2

ChatGPT said:
ChatGPT
Here’s how to create an always-orange circle with "参加予定" text and handle it to display for false for now. No edit button is included as per your updated requirement.

Code Implementation
tsx
Copy code
import React from "react";
import { Box, Typography } from "@mui/material";

const EventStatus = () => {
  // State to handle the display logic
  const isDisplayed = false; // For now, always set to false

  return (
    <Box
      sx={{
        display: isDisplayed ? "flex" : "none", // Show only when `isDisplayed` is true
        alignItems: "center",
        justifyContent: "center",
        backgroundColor: "#FFA500", // Orange color
        color: "#fff",
        borderRadius: "50%",
        width: "80px", // Adjust circle size
        height: "80px",
        textAlign: "center",
        fontSize: "14px",
        fontWeight: "bold",
        boxShadow: "0 2px 4px rgba(0,0,0,0.1)",
      }}
    >
      <Typography sx={{ fontSize: "14px", fontWeight: "bold" }}>参加予定</Typography>
    </Box>
  );
};

export default EventStatus;
Key Features
Always Orange Circle:

The circle is styled using borderRadius: "50%" and backgroundColor: "#FFA500" (orange).
Handle Display:

The circle's visibility is controlled by the isDisplayed variable.
Currently, it is set to false, so the circle won't appear.
Typography Inside Circle:

The text "参加予定" is centered inside the circle using alignItems and justifyContent.
Usage Example
tsx
Copy code
import EventStatus from "./EventStatus";

const App = () => {
  return (
    <div>
      <h1>Event Details</h1>
      <EventStatus />
    </div>
  );
};

export default App;
Expected Behavior
When isDisplayed is false:
