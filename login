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

The circle will not render (hidden from view).
When isDisplayed is true:

The orange circle with "参加予定" will be visible.
Customization Options
To permanently show the circle, set isDisplayed = true:
tsx
Copy code
const isDisplayed = true;
