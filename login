import request from 'supertest';
import { server } from '../app';
import { getDbClient } from '../config/dbClient';
import { referenceNumberManager } from '../utils/referenceNumberManager';
import {
  deleteUserIdentificationData,
  deleteJpkiIdentificationData,
  insertUserIdentificationData,
  insertJpkiIdentificationData,
} from '../helpers/deleteTestDataHelpers';
import { initAndGetReferenceNumberList, deleteTestDataForEachReferenceNumber } from '../helpers/referenceNumberHelpers';

const sendDeleteRequest = ({
  referenceNumber = referenceNumberManager.referenceNumber(),
  userType = 'AGENT',
} = {}) =>
  request(server)
    .delete(`/applications/identification-data`)
    .set('reference-number', referenceNumber)
    .send({ userType });

let dbClient: any;

beforeAll(async () => {
  dbClient = await getDbClient();
  await referenceNumberManager.initialize(dbClient);
  await initAndGetReferenceNumberList();
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
  await deleteTestDataForEachReferenceNumber();
});

// Test Suite
describe('DELETE /applications/identification-data', () => {
  describe('正常系 (Normal Cases)', () => {
    it('should delete data for AGENT successfully and keep BENEFICIARY data intact', async () => {
      const referenceNumber = referenceNumberManager.referenceNumber();

      // Call delete API for AGENT
      const { status, body } = await sendDeleteRequest({ referenceNumber, userType: 'AGENT' });

      expect(status).toBe(204);
      expect(body).toEqual({});

      // Verify AGENT data is deleted
      const identificationData = await dbClient.execute(
        `SELECT * FROM open_account_identification_data WHERE reference_number = $1 AND user_type = 'AGENT'`,
        [referenceNumber]
      );
      expect(identificationData.rowCount).toBe(0);

      const jpkiData = await dbClient.execute(
        `SELECT * FROM jpki_identification_data WHERE reference_number = $1 AND user_type = 'AGENT'`,
        [referenceNumber]
      );
      expect(jpkiData.rowCount).toBe(0);

      // Verify BENEFICIARY data is still present
      const beneficiaryData = await dbClient.execute(
        `SELECT * FROM open_account_identification_data WHERE reference_number = $1 AND user_type = 'BENEFICIARY1'`,
        [referenceNumber]
      );
      expect(beneficiaryData.rowCount).toBe(1);
    });

    it('should delete data for REPRESENTATIVE successfully and keep BENEFICIARY data intact', async () => {
      const referenceNumber = referenceNumberManager.referenceNumber();

      // Call delete API for REPRESENTATIVE
      const { status, body } = await sendDeleteRequest({ referenceNumber, userType: 'REPRESENTATIVE' });

      expect(status).toBe(204);
      expect(body).toEqual({});

      // Verify REPRESENTATIVE data is deleted
      const identificationData = await dbClient.execute(
        `SELECT * FROM open_account_identification_data WHERE reference_number = $1 AND user_type = 'REPRESENTATIVE'`,
        [referenceNumber]
      );
      expect(identificationData.rowCount).toBe(0);

      const jpkiData = await dbClient.execute(
        `SELECT * FROM jpki_identification_data WHERE reference_number = $1 AND user_type = 'REPRESENTATIVE'`,
        [referenceNumber]
      );
      expect(jpkiData.rowCount).toBe(0);

      // Verify BENEFICIARY data is still present
      const beneficiaryData = await dbClient.execute(
        `SELECT * FROM open_account_identification_data WHERE reference_number = $1 AND user_type = 'BENEFICIARY1'`,
        [referenceNumber]
      );
      expect(beneficiaryData.rowCount).toBe(1);
    });
  });

  describe('異常系 (Error Cases)', () => {
    it('should return 404 when the reference number does not exist', async () => {
      const referenceNumber = 'non-existent-reference';

      const { status, body } = await sendDeleteRequest({ referenceNumber });

      expect(status).toBe(404);
      expect(body).toEqual({ error: 'Invalid reference number' });
    });

    it('should return 500 when there is an error during deletion', async () => {
      const referenceNumber = referenceNumberManager.referenceNumber();

      // Mock a deletion error
      jest.spyOn(dbClient, 'execute').mockRejectedValueOnce(new Error('Deletion error'));

      const { status, body } = await sendDeleteRequest({ referenceNumber, userType: 'AGENT' });

      expect(status).toBe(500);
      expect(body).toEqual({ error: 'Internal Server Error' });
    });
  });
});
