Updated Code for CardContentBox
tsx
Copy code
import React from "react";
import { Box } from "@mui/material";
import EventParticipateTag from "./EventParticipateTag"; // Ensure this is correctly imported

const CardContentBox = ({ id, name, image, tags, circleName, date, participants, userId }) => {
  const isIncludeUserIdInParticipantsList = participants
    ? participants.includes(userId?.toString())
    : false;

  return (
    <Box
      key={name + "card" + id.toString()}
      onClick={() => onClickInfoBtn(id)}
      sx={{
        border: "1px solid #E4E7E7",
        width: "48%",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        borderRadius: "8px",
        boxShadow: 3,
        pt: 2,
        mb: 2,
        bgcolor: "#FFFFFF",
        position: "relative", // Ensure the container is positioned relatively for the tag to be positioned
      }}
    >
      {/* Image */}
      <img
        src={image}
        alt={image}
        style={{
          width: "100%",
          height: "120px",
          objectFit: "cover",
        }}
      />

      {/* Display 参加予定 Tag */}
      {isIncludeUserIdInParticipantsList && (
        <Box
          sx={{
            position: "absolute",
            top: "10px",
            right: "10px",
            background: "#F18F01",
            color: "#FFFFFF",
            borderRadius: "20px",
            padding: "4px 12px",
            fontSize: "14px",
            fontWeight: 600,
          }}
        >
          参加予定
        </Box>
      )}

      {/* Event Details */}
      <Box sx={{ height: "8px" }} />
      <MainNameBox name={name} />
      <ContentType name="Event" circleName={circleName} />
      <ContentType name="Event" dateBoxForEvent date={date} />
      <Box sx={{ height: "4px" }} />
      <TagListBox tags={tags} />
    </Box>
  );
};

export default CardContentBox;
Key Changes
Added isIncludeUserIdInParticipantsList Logic:

Accept participants and userId as props in the CardContentBox component.
Determine if the current user is participating using the same logic as the EventInfo page.
Positioned Tag:

Added the 参加予定 tag in a Box with position: absolute at the top-right corner of the CardContentBox.
Dynamic Display:

The 参加予定 tag only renders if isIncludeUserIdInParticipantsList is true.
Example Usage
tsx
Copy code
<CardContentBox
  id={event.id}
  name={event.name}
  image={event.image}
  tags={event.tags}
  circleName={event.circleName}
  date={event.date}
  participants={event.participants}
  userId={currentUser?.id} // Pass the logged-in user's ID
/>
Result
