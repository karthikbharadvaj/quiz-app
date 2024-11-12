import request from 'supertest';
import { server } from '../app';
import { getDbClient } from '../config/dbClient';
import { referenceNumberManager } from '../utils/referenceNumberManager';
import {
  deleteUserIdentificationData,
  deleteJpkiIdentificationData,
  insertUserIdentificationData,
  insertJpkiIdentificationData,
} from '../helpers/testDataHelpers';

// ==============================
// HELPERS
// ==============================

/**
 * Helper function to send a DELETE request to the API.
 * Sets the `reference-number` header and sends `userType` in the request body.
 */
const sendDeleteRequest = ({
  referenceNumber = referenceNumberManager.referenceNumber(),
  userType = 'AGENT',
} = {}) =>
  request(server)
    .delete(`/applications/identification-data`)
    .set('reference-number', referenceNumber)
    .send({ userType });

/**
 * Helper function to verify that data for a given `userType` is deleted from both tables.
 */
const verifyDataDeleted = async (referenceNumber: string, userType: string) => {
  const identificationData = await dbClient.execute(
    `SELECT * FROM open_account_identification_data WHERE reference_number = $1 AND user_type = $2`,
    [referenceNumber, userType]
  );
  expect(identificationData.rowCount).toBe(0);

  const jpkiData = await dbClient.execute(
    `SELECT * FROM jpki_identification_data WHERE reference_number = $1 AND user_type = $2`,
    [referenceNumber, userType]
  );
  expect(jpkiData.rowCount).toBe(0);
};

/**
 * Helper function to verify that data for `BENEFICIARY1` is still present in both tables.
 */
const verifyBeneficiaryDataPresent = async (referenceNumber: string) => {
  const beneficiaryData = await dbClient.execute(
    `SELECT * FROM open_account_identification_data WHERE reference_number = $1 AND user_type = 'BENEFICIARY1'`,
    [referenceNumber]
  );
  expect(beneficiaryData.rowCount).toBe(1);

  const beneficiaryJpkiData = await dbClient.execute(
    `SELECT * FROM jpki_identification_data WHERE reference_number = $1 AND user_type = 'BENEFICIARY'`,
    [referenceNumber]
  );
  expect(beneficiaryJpkiData.rowCount).toBe(1);
};

// ==============================
// SETUP
// ==============================

let dbClient: any;

beforeAll(async () => {
  dbClient = await getDbClient();
  await referenceNumberManager.initialize(dbClient);
});

beforeEach(async () => {
  await deleteUserIdentificationData();
  await deleteJpkiIdentificationData();
  jest.resetAllMocks();
  jest.restoreAllMocks();

  // Insert test data for AGENT, REPRESENTATIVE, and BENEFICIARY1
  await insertUserIdentificationData('AGENT', { testData: 'AGENT data' });
  await insertUserIdentificationData('REPRESENTATIVE', { testData: 'REPRESENTATIVE data' });
  await insertUserIdentificationData('BENEFICIARY1', { testData: 'BENEFICIARY1 data' });

  await insertJpkiIdentificationData('1', 'AGENT', { jpkiData: 'AGENT jpki data' });
  await insertJpkiIdentificationData('2', 'REPRESENTATIVE', { jpkiData: 'REPRESENTATIVE jpki data' });
  await insertJpkiIdentificationData('3', 'BENEFICIARY', { jpkiData: 'BENEFICIARY jpki data' });
});

afterAll(async () => {
  await deleteUserIdentificationData();
  await deleteJpkiIdentificationData();
  await referenceNumberManager.cleanup();
});

// ==============================
// TEST
// ==============================

describe('DELETE /applications/identification-data (Success Cases)', () => {
  it('should delete data for AGENT and retain BENEFICIARY data', async () => {
    const referenceNumber = referenceNumberManager.referenceNumber();

    // Call the DELETE API for AGENT userType
    const { status, body } = await sendDeleteRequest({ referenceNumber, userType: 'AGENT' });

    // Verify the API response
    expect(status).toBe(204);
    expect(body).toEqual({});

    // Verify that AGENT data is deleted
    await verifyDataDeleted(referenceNumber, 'AGENT');

    // Verify that BENEFICIARY data is still present
    await verifyBeneficiaryDataPresent(referenceNumber);
  });

  it('should delete data for REPRESENTATIVE and retain BENEFICIARY data', async () => {
    const referenceNumber = referenceNumberManager.referenceNumber();

    // Call the DELETE API for REPRESENTATIVE userType
    const { status, body } = await sendDeleteRequest({ referenceNumber, userType: 'REPRESENTATIVE' });

    // Verify the API response
    expect(status).toBe(204);
    expect(body).toEqual({});

    // Verify that REPRESENTATIVE data is deleted
    await verifyDataDeleted(referenceNumber, 'REPRESENTATIVE');

    // Verify that BENEFICIARY data is still present
    await verifyBeneficiaryDataPresent(referenceNumber);
  });
});

import request from 'supertest';
import { server } from '../app';
import { getDbClient } from '../config/dbClient';
import { referenceNumberManager } from '../utils/referenceNumberManager';

// Helper Functions

const sendRequest = ({
  userUid = referenceNumberManager.userUid(),
  referenceNumber = referenceNumberManager.referenceNumber(),
  userType = 'REPRESENTATIVE',
} = {}) =>
  request(server)
    .delete(`/applications/identification-data`)
    .set('user-uid', userUid)
    .send({ referenceNumber, userType });

const deleteUserIdentificationData = async (referenceNumber?: string) => {
  const dbClient = await getDbClient();
  await dbClient.execute(`DELETE FROM identification WHERE reference_number = $1`, [
    referenceNumber ?? referenceNumberManager.referenceNumber(),
  ]);
};

const deleteUserScreeningData = async () => {
  const dbClient = await getDbClient();
  await dbClient.execute(`DELETE FROM screening_status WHERE reference_number = $1`, [
    referenceNumberManager.referenceNumber(),
  ]);
};

const deleteApplicationData = async (referenceNumber?: string) => {
  const dbClient = await getDbClient();
  await dbClient.execute(`DELETE FROM application WHERE reference_number = $1`, [
    referenceNumber ?? referenceNumberManager.referenceNumber(),
  ]);
};

const deleteJpkiIdentificationData = async (referenceNumber?: string) => {
  const dbClient = await getDbClient();
  await dbClient.execute(`DELETE FROM jpki_identification WHERE reference_number = $1`, [
    referenceNumber ?? referenceNumberManager.referenceNumber(),
  ]);
};

const initAndGetReferenceNumberList = async () => {
  referenceNumberManager.referenceNumber1 = await referenceNumberManager.issueReferenceNumber('userUid1');
  referenceNumberManager.referenceNumber2 = await referenceNumberManager.issueReferenceNumber('userUid2');
  referenceNumberManager.referenceNumber3 = await referenceNumberManager.issueReferenceNumber('userUid3');
  referenceNumberManager.referenceNumber4 = await referenceNumberManager.issueReferenceNumber('userUid4');
};

const deleteTestDataForEachReferenceNumber = async () => {
  await Promise.all(
    ['referenceNumber1', 'referenceNumber2', 'referenceNumber3', 'referenceNumber4'].map(async (key) => {
      await deleteUserIdentificationData(referenceNumberManager[key]);
      await deleteApplicationData(referenceNumberManager[key]);
      await deleteJpkiIdentificationData(referenceNumberManager[key]);
    })
  );
};

// Setup and Teardown

let dbClient: any;

beforeAll(async () => {
  dbClient = await getDbClient();
  await referenceNumberManager.initialize(dbClient);
  await initAndGetReferenceNumberList();
});

beforeEach(async () => {
  await deleteUserIdentificationData();
  await deleteUserScreeningData();
  await deleteApplicationData();
  await deleteJpkiIdentificationData();
});

afterAll(async () => {
  await deleteUserIdentificationData();
  await deleteUserScreeningData();
  await deleteApplicationData();
  await deleteJpkiIdentificationData();
  await referenceNumberManager.cleanup();
  await deleteTestDataForEachReferenceNumber();
  await dbClient.close();
});

// Test Suite

describe('DELETE /applications/identification-data', () => {
  describe('Normal Cases', () => {
    it('returns 204 when identification data for REPRESENTATIVE is deleted successfully', async () => {
      const referenceNumber = referenceNumberManager.referenceNumber1;

      const response = await sendRequest({ referenceNumber, userType: 'REPRESENTATIVE' });

      if (response.status !== 204) {
        throw new Error(`Expected status 204, but got ${response.status}`);
      }

      if (Object.keys(response.body).length !== 0) {
        throw new Error(`Expected empty body, but got ${JSON.stringify(response.body)}`);
      }
    });
  });

  describe('Error Cases', () => {
    it('returns 404 when the reference number does not exist', async () => {
      const referenceNumber = 'non-existent-reference';

      const response = await sendRequest({ referenceNumber });

      if (response.status !== 404) {
        throw new Error(`Expected status 404, but got ${response.status}`);
      }

      if (response.body.error !== 'Invalid reference number') {
        throw new Error(`Expected error 'Invalid reference number', but got ${response.body.error}`);
      }
    });

    it('returns 500 when deletion from IdentificationAftConnectionDataRepository fails', async () => {
      await dbClient.execute(`UPDATE identification SET user_type = 'INVALID' WHERE reference_number = $1`, [
        referenceNumberManager.referenceNumber1,
      ]);

      const response = await sendRequest();

      if (response.status !== 500) {
        throw new Error(`Expected status 500, but got ${response.status}`);
      }

      if (response.body.error !== 'Internal Server Error') {
        throw new Error(`Expected error 'Internal Server Error', but got ${response.body.error}`);
      }
    });

    it('returns 500 when deletion from IdentificationDataRepository fails', async () => {
      await dbClient.execute(`UPDATE identification SET saved_data = NULL WHERE reference_number = $1`, [
        referenceNumberManager.referenceNumber2,
      ]);

      const response = await sendRequest({ referenceNumber: referenceNumberManager.referenceNumber2 });

      if (response.status !== 500) {
        throw new Error(`Expected status 500, but got ${response.status}`);
      }

      if (response.body.error !== 'Internal Server Error') {
        throw new Error(`Expected error 'Internal Server Error', but got ${response.body.error}`);
      }
    });

    it('returns 500 when update operation in OpenAccountApplicationRepository fails', async () => {
      await dbClient.execute(`UPDATE application SET is_valid = NULL WHERE reference_number = $1`, [
        referenceNumberManager.referenceNumber3,
      ]);

      const response = await sendRequest({ referenceNumber: referenceNumberManager.referenceNumber3 });

      if (response.status !== 500) {
        throw new Error(`Expected status 500, but got ${response.status}`);
      }

      if (response.body.error !== 'Internal Server Error') {
        throw new Error(`Expected error 'Internal Server Error', but got ${response.body.error}`);
      }
    });
  });
});
