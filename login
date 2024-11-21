Updated Code with Dynamic Participation Handling
tsx
Copy code
import React from "react";
import { Box, Typography, Button } from "@mui/material";

const YourComponent = ({ tags, isParticipating, onClickJoinBtn, onClickCancelParticipation }) => {
  return (
    <Box
      sx={{
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center",
        width: "100%",
        marginBottom: 2,
      }}
    >
      {/* Tags aligned to the left */}
      <TagListBox tags={tags} />

      {/* Right section */}
      <Box sx={{ display: "flex", alignItems: "center", gap: 2 }}>
        {isParticipating ? (
          // Display "参加予定" tag if the user is participating
          <Box
            sx={{
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              background: "#F18F01",
              color: "#FFFFFF",
              borderRadius: "50px",
              padding: "6px 12px",
              fontSize: "14px",
            }}
          >
            参加予定
          </Box>
        ) : (
          // Display participate button if the user is not participating
          <Button
            sx={{
              borderRadius: 10,
              background: "#429ADD",
              color: "#FFFFFF",
              height: 40,
              padding: "0 16px",
              textTransform: "none",
              fontSize: "16px",
            }}
            onClick={onClickJoinBtn}
          >
            参加する
          </Button>
        )}
        {/* Cancel button for participating users */}
        {isParticipating && (
          <Button
            sx={{
              borderRadius: 10,
              background: "#D32F2F",
              color: "#FFFFFF",
              height: 40,
              padding: "0 16px",
              textTransform: "none",
              fontSize: "16px",
            }}
            onClick={onClickCancelParticipation}
          >
            参加キャンセル
          </Button>
        )}
      </Box>
    </Box>
  );
};

export default YourComponent;
Explanation of Changes
Dynamic Rendering:

If the user is participating (isParticipating === true), display the "参加予定" tag.
If not, display the "参加する" button.
Cancel Button:

A "参加キャンセル" button is added when the user is participating, allowing them to cancel their participation.
Styling:

The "参加予定" tag is styled as a rounded orange circle with white text.
The buttons ("参加する" and "参加キャンセル") are styled with different colors to differentiate their purposes.
