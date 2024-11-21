Complete Controller File: deleteApplicationDataController.ts
typescript
Copy code
import { Request, Response, NextFunction } from 'express';
import { DeleteApplicantIdentificationDataUseCase } from '../useCases/DeleteApplicantIdentificationDataUseCase';

/**
 * Controller to delete applicant identification data.
 */
export async function deleteApplicationDataController(
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const { referenceNumber, userType } = req.body;

    // Validate request body
    if (!referenceNumber || !userType) {
      return res.status(400).json({ error: 'Reference number and user type are required.' });
    }

    // Instantiate and execute the use case
    const deleteUseCase = new DeleteApplicantIdentificationDataUseCase();
    await deleteUseCase.execute({ referenceNumber, userType });

    // Respond with a success status
    res.status(204).send();
  } catch (error) {
    console.error('Error in deleteApplicationDataController:', error);
    next(error); // Pass error to middleware
  }
}
Complete Use Case File: DeleteApplicantIdentificationDataUseCase.ts
typescript
Copy code
import { getDbClient } from '../config/dbClient';

/**
 * Use case to handle deletion of applicant identification data.
 */
export class DeleteApplicantIdentificationDataUseCase {
  /**
   * Executes the deletion of applicant identification data.
   *
   * @param {Object} params - Parameters for the deletion process.
   * @param {string} params.referenceNumber - The reference number for the applicant.
   * @param {string} params.userType - The user type ('AGENT' or 'REPRESENTATIVE').
   */
  async execute({ referenceNumber, userType }: { referenceNumber: string; userType: string }): Promise<void> {
    const dbClient = await getDbClient();

    try {
      // Perform deletion in parallel
      await Promise.all([
        dbClient.execute(
          `DELETE FROM jpki_identification_table WHERE reference_number = $1 AND user_type = $2`,
          [referenceNumber, userType]
        ),
        dbClient.execute(
          `DELETE FROM application_table WHERE reference_number = $1`,
          [referenceNumber]
        ),
      ]);

      // Update validation status
      await dbClient.execute(
        `UPDATE application_status_table SET is_valid = false WHERE reference_number = $1`,
        [referenceNumber]
      );
    } catch (error) {
      console.error('Error executing DeleteApplicantIdentificationDataUseCase:', error);
      throw new Error('Failed to delete applicant identification data.');
    } finally {
      // Close the database connection if needed
      await dbClient.close();
    }
  }
}
Supporting Config: dbClient.ts
If the getDbClient function is not defined, you need to implement it. Below is an example configuration for managing a PostgreSQL database client:

typescript
Copy code
import { Pool, PoolClient } from 'pg';

let pool: Pool;

/**
 * Initialize the database pool if not already initialized.
 */
function initializePool(): Pool {
  if (!pool) {
    pool = new Pool({
      user: process.env.DB_USER,
      host: process.env.DB_HOST,
      database: process.env.DB_NAME,
      password: process.env.DB_PASSWORD,
      port: Number(process.env.DB_PORT),
    });
  }
  return pool;
}

/**
 * Get a database client from the connection pool.
 */
export async function getDbClient(): Promise<PoolClient> {
  const pool = initializePool();
  return pool.connect();
}
Router File: routes.ts
Integrate the controller into your Express router:

typescript
Copy code
import { Router } from 'express';
import { deleteApplicationDataController } from '../controllers/deleteApplicationDataController';

const router = Router();

// Route to handle the deletion of applicant identification data
router.delete('/applications/identification-data', deleteApplicationDataController);

export default router;
Folder Structure
Ensure your folder structure is organized as follows:

arduino
Copy code
src/
├── config/
│   └── dbClient.ts
├── controllers/
│   └── deleteApplicationDataController.ts
├── useCases/
│   └── DeleteApplicantIdentificationDataUseCase.ts
├── routes/
│   └── routes.ts
Key Features
Controller:

Validates the request body.
Instantiates and invokes the DeleteApplicantIdentificationDataUseCase.
Use Case:

Handles the core logic for deleting data.
Deletes data from jpki_identification_table and application_table.
Updates the validation status in application_status_table.
Uses Promise.all for concurrent operations.
Database Client:

Implements getDbClient to manage the database connection pool.
Ensures efficient and reusable database operations.
Error Handling:

Errors in the use case are propagated to the controller, which logs them and passes them to middleware.
Example Environment Variables
Ensure your .env file includes the following database configuration:

env
Copy code
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_HOST=localhost
DB_PORT=5432
DB_NAME=your_database_name
Testing the Controller
Test Case for Controller
Use a tool like Jest to test the controller:

typescript
Copy code
import request from 'supertest';
import { server } from '../app'; // Assuming your Express app is exported from app.ts

describe('DELETE /applications/identification-data', () => {
  it('should delete applicant identification data successfully', async () => {
    const response = await request(server)
      .delete('/applications/identification-data')
      .send({ referenceNumber: '123456', userType: 'AGENT' });

    expect(response.status).toBe(204);
  });

  it('should return 400 if referenceNumber or userType is missing', async () => {
    const response = await request(server)
      .delete('/applications/identification-data')
      .send({ userType: 'AGENT' }); // Missing referenceNumber

    expect(response.status).toBe(400);
    expect(response.body).toEqual({ error: 'Reference number and user type are required.' });
  });
});
Summary
