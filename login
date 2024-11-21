
Here’s how you can structure the delete use case for the above context, leveraging a similar structure to the provided getApplicationData use case but tailored for deletion:

Delete Use Case
This use case will:

Extract necessary data (like referenceNumber and userType) from the request.
Perform deletions using repositories or API clients.
Return appropriate HTTP status codes and results.
Here’s how the delete use case might look:

typescript
Copy code
import { Request, Response, NextFunction } from 'express';
import { apiClient } from '../api/apiClient';
import { AxiosRequestConfig } from 'axios';
import { DeleteApplicantIdentificationDataUseCase } from '../useCases/DeleteApplicantIdentificationDataUseCase';

export function deleteApplicationData(
  req: Request,
  res: Response,
  next: NextFunction
): void {
  const path = 'api/open-bank-account/applications'; // Backend API endpoint
  const config: AxiosRequestConfig = {
    headers: {
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    },
    responseType: 'json',
  };

  const { referenceNumber, userType } = req.body;

  apiClient
    .delete(path, {
      ...config,
      data: {
        referenceNumber,
        userType,
      },
    })
    .then(() => {
      const useCase = new DeleteApplicantIdentificationDataUseCase({
        referenceNumber,
        userType,
      });

      // Perform the deletion via the use case
      return useCase.deleteIdentificationData();
    })
    .then(() => {
      // Respond with success
      res.status(204).json({
        message: 'Applicant identification data deleted successfully',
      });
    })
    .catch((err) => {
      next(err); // Pass the error to the error handler
    });
}
Explanation
Request Handling:

Extracts the referenceNumber and userType from the request body.
API Client Deletion:

Calls the backend delete endpoint with the necessary data.
Use Case Integration:

Initializes and executes the DeleteApplicantIdentificationDataUseCase to handle application-specific logic.
Error Handling:

Any errors encountered during the API call or use case execution are passed to the next middleware using next(err).
DeleteApplicantIdentificationDataUseCase
Below is an example of how the DeleteApplicantIdentificationDataUseCase might look, focusing on business logic:

typescript
Copy code
export class DeleteApplicantIdentificationDataUseCase {
  private referenceNumber: string;
  private userType: string;

  constructor({ referenceNumber, userType }: { referenceNumber: string; userType: string }) {
    this.referenceNumber = referenceNumber;
    this.userType = userType;
  }

  async deleteIdentificationData(): Promise<void> {
    try {
      const dbClient = await getDbClient();

      // Perform database deletions
      await Promise.all([
        dbClient.execute(
          `DELETE FROM jpki_identification_table WHERE reference_number = $1 AND user_type = $2`,
          [this.referenceNumber, this.userType]
        ),
        dbClient.execute(
          `DELETE FROM application_table WHERE reference_number = $1`,
          [this.referenceNumber]
        ),
      ]);

      // Optionally update other states, such as validation
      await dbClient.execute(
        `UPDATE application_status_table SET is_valid = false WHERE reference_number = $1`,
        [this.referenceNumber]
      );
    } catch (error) {
      console.error('Error deleting applicant identification data:', error);
      throw new Error('Failed to delete applicant identification data');
    }
  }
}
Key Features
Parallel Deletion:

Uses Promise.all to delete data from multiple tables concurrently.
Improves efficiency for independent deletions.
Error Handling:

Logs errors to assist with debugging.
Throws meaningful errors for higher-level handling.
Database Operations:

Deletes the applicant's identification data from the jpki_identification_table.
Deletes related records from the application_table.
Validation Updates:

Updates the is_valid field in the application_status_table to reflect the deletion.
Integration in Router
Add the controller to your routing setup:

typescript
Copy code
import { Router } from 'express';
import { deleteApplicationData } from '../controllers/deleteApplicationDataController';

const router = Router();

router.delete('/applications/identification-data', deleteApplicationData);

export default router;
Frontend Example
If the frontend triggers the delete request, it will send the referenceNumber and userType in the body of the DELETE request, which will then be processed by the backend.

Frontend Request
typescript
Copy code
import axios from 'axios';

const deleteApplicantIdentificationData = async (referenceNumber: string, userType: string) => {
  try {
    const response = await axios.delete('/api/applications/identification-data', {
      data: {
        referenceNumber,
        userType,
      },
    });
    if (response.status === 204) {
      console.log('Data deleted successfully');
    }
  } catch (error) {
    console.error('Error deleting applicant identification data:', error);
  }
};
Summary
