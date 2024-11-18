<Box sx={{ display: "flex", gap: 2, alignItems: "center", marginTop: 2 }}>
    {members.map((member) => (
        <Box key={member.id} sx={{ textAlign: "center" }}>
            <img
                src={member.avatarUrl || "/images/default-avatar.png"}
                alt={member.name}
                style={{
                    width: "40px",
                    height: "40px",
                    borderRadius: "50%",
                    objectFit: "cover",
                }}
            />
            <Typography variant="body2">{member.name}</Typography>
        </Box>
    ))}
</Box>
