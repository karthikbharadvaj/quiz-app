Update the fetchEventParticipants function to process the response:

tsx
Copy code
import axios, { AxiosRequestConfig } from "axios";
import { UserInfoTypeFromBackendRes } from "../entities/user";

export const fetchEventParticipants = async (
  id: string
): Promise<{ name: string; department: string }[]> => {
  const options: AxiosRequestConfig = {
    url: `event/participants/${id}`,
    method: "GET",
  };

  const { data } = await axios<UserInfoTypeFromBackendRes[]>(options);

  // Map and extract the required fields (name and department)
  return data.map((participant) => ({
    name: participant.name,
    department: participant.department || "Unknown", // Fallback for undefined departments
  }));
};
Key Changes
Explicit Typing of Response:

The axios call is typed as UserInfoTypeFromBackendRes[], ensuring TypeScript knows the structure of the returned data.
Mapping the Response:

The response is mapped to extract only name and department.
Fallback for department:

If department is optional (string | undefined), provide a fallback value like "Unknown".
Proper Return Type:

The function now explicitly returns Promise<{ name: string; department: string }[]>, which aligns with the expected usage.
Updated UserInfoTypeFromBackendRes
Ensure the UserInfoTypeFromBackendRes type includes all the fields returned by the backend:

tsx
Copy code
export type UserInfoTypeFromBackendRes = {
  id: number;
  name: string;
  password: string;
  department?: string; // Optional
  email?: string;
  tags?: string[];
  participants?: string[];
};
Testing the Function
To test the fetchEventParticipants function:

tsx
Copy code
fetchEventParticipants("1")
  .then((participants) => {
    console.log(participants);
    // Expected output:
    // [
    //   { name: "John", department: "Engineering" },
    //   { name: "Jane", department: "Marketing" },
    // ]
  })
  .catch((err) => {
    console.error("Error fetching participants:", err);
  });
Final Thoughts
With this approach:

The response is correctly transforme
