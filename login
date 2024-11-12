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
