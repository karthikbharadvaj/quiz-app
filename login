
Step 1: Pass id to the Custom Hook
In the component where you use useEventInfo, ensure the id is passed as an argument. You can get the id from the route parameters using useParams from react-router-dom.

tsx
Copy code
import { useParams } from "react-router-dom";
import { useEventInfo } from "../hooks/useEventInfo";

const EventInfo = () => {
  const { id } = useParams<{ id: string }>(); // Extract the ID from the route

  const {
    title,
    tags,
    contents,
    participantNameList,
    onFetchEventInfo,
    onFetchEventParticipants,
  } = useEventInfo(id ?? "1"); // Pass the ID to the hook

  useEffect(() => {
    onFetchEventInfo();
    onFetchEventParticipants();
  }, [onFetchEventInfo, onFetchEventParticipants]);

  return (
    <div>
      {/* Your component UI */}
    </div>
  );
};

export default EventInfo;
Step 2: Update the Custom Hook
Ensure the useEventInfo hook is designed to accept the id parameter:

tsx
Copy code
import { useState, useEffect } from "react";
import { fetchEventParticipants } from "../services/fetchEventParticipants";

export const useEventInfo = (id: string) => {
  const [participantNameList, setParticipantNameList] = useState<
    { name: string; department: string }[]
  >([]);

  const onFetchEventParticipants = async () => {
    try {
      const data = await fetchEventParticipants(id);
      setParticipantNameList(data); // Set the fetched data
    } catch (err) {
      console.error("Error fetching participants:", err);
    }
  };

  return {
    participantNameList,
    onFetchEventParticipants,
  };
};
Step 3: Ensure the Route Includes id
Make sure your EventInfo route in App.tsx or Routes.tsx includes the id parameter:

tsx
Copy code
<Routes>
  <Route path="/EventInfo/:id" element={<EventInfo />} />
</Routes>
Why This Works
useParams Extracts the Route Parameter:

useParams is used to fetch the id from the route, which is then passed to the useEventInfo hook.
Custom Hook Requires the id:

The hook fetches the participant data for the specific id.
Avoid Missing Arguments:

By ensuring id is always passed, you avoid the Expected 1 arguments, but got 0 error.
Final Code
Here’s the corrected setup:

EventInfo Component:
tsx
Copy code
import { useParams } from "react-router-dom";
import { useEffect } from "react";
import { useEventInfo } from "../hooks/useEventInfo";

const EventInfo = () => {
  const { id } = useParams<{ id: string }>(); // Extract ID from route

  const {
    participantNameList,
    onFetchEventParticipants,
  } = useEventInfo(id ?? "1"); // Pass ID to hook

  useEffect(() => {
    onFetchEventParticipants(); // Fetch participants on mount
  }, [onFetchEventParticipants]);

  return (
    <div>
      <h1>Event Participants</h1>
      {/* Render participantNameList */}
    </div>
  );
};

export default EventInfo;
Custom Hook:
tsx
Copy code
import { useState } from "react";
import { fetchEventParticipants } from "../services/fetchEventParticipants";

export const useEventInfo = (id: string) => {
  const [participantNameList, setParticipantNameList] = useState<
    { name: string; department: string }[]
  >([]);

  const onFetchEventParticipants = async () => {
    try {
      const data = await fetchEventParticipants(id);
      setParticipantNameList(data);
    } catch (err) {
      console.error("Error fetching participants:", err);
    }
  };

  return {
    participantNameList,
    onFetchEventParticipants,
  };
};
Let me know if you encounter further issues!






