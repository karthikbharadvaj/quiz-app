{participantNameList.map(({ name, department }, index) => (
    <Box key={index} sx={{ display: "flex", alignItems: "center", mb: 2 }}>
        <Avatar sx={{ width: 40, height: 40, bgcolor: "#3f51b5", mr: 2 }}>
            {name.charAt(0).toUpperCase()}
        </Avatar>
        <Box>
            <Typography variant="body1" sx={{ fontWeight: 600 }}>
                {name}
            </Typography>
            <Typography variant="body2" sx={{ color: "#6e6e6e" }}>
                {department}
            </Typography>
        </Box>
    </Box>
))}
