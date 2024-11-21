
const EventStatus = () => {
  // State to control display (currently false, so it won't display)
  const isDisplayed = false; // Change to `true` to display the oval

  return (
    <Box
      sx={{
        display: isDisplayed ? "flex" : "none", // Show only when `isDisplayed` is true
        alignItems: "center",
        justifyContent: "center",
        backgroundColor: "#FFA500", // Orange color
        color: "#fff",
        borderRadius: "20px", // High border radius for oval shape
        width: "120px", // Adjust width for the oval shape
        height: "40px", // Adjust height for the oval shape
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
Key Adjustments for Oval Shape
Oval Shape Styling:

The width is greater than the height (e.g., 120px width and 40px height).
borderRadius: "20px" ensures smooth corners and creates the oval effect.
Dynamic Display Control:

isDisplayed is set to false initially, so the oval will not render.
Set isDisplayed = true to show the oval.
