import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import axios from 'axios';
import { NewBankApplyIdentityConfirmationApplicant } from '../NewBankApplyIdentityConfirmationApplicant';

jest.mock('axios');
const mockedAxios = axios as jest.Mocked<typeof axios>;

describe('やり直す Button Behavior', () => {
  it('should display the modal and delete data when やり直す is clicked', async () => {
    // Mock API response for deletion
    mockedAxios.delete.mockResolvedValueOnce({ status: 204 });

    // Render the component
    render(<NewBankApplyIdentityConfirmationApplicant />);

    // Ensure the やり直す button is present initially
    const yarinaosuButton = screen.getByRole('button', { name: 'やり直す' });
    expect(yarinaosuButton).toBeInTheDocument();

    // Click on the やり直す button
    fireEvent.click(yarinaosuButton);

    // Ensure the modal appears
    const modalText = screen.getByText('本当にやり直しますか?');
    expect(modalText).toBeInTheDocument();

    // Ensure the modal's やり直す button is present
    const modalYarinaosuButton = screen.getByRole('button', { name: 'やり直す' });
    expect(modalYarinaosuButton).toBeInTheDocument();

    // Click the modal's やり直す button
    fireEvent.click(modalYarinaosuButton);

    // Wait for the API call to resolve
    await waitFor(() => expect(mockedAxios.delete).toHaveBeenCalledWith('/mockurl', {
      data: { referenceNumber: 'mockReferenceNumber', userType: 'AGENT' },
    }));

    // Ensure the やり直す button is no longer visible
    await waitFor(() => expect(screen.queryByRole('button', { name: 'やり直す' })).not.toBeInTheDocument());
  });

  it('should display an error message if the API call fails', async () => {
    // Mock API failure
    mockedAxios.delete.mockRejectedValueOnce(new Error('Mock API Error'));

    // Render the component
    render(<NewBankApplyIdentityConfirmationApplicant />);

    // Click on the やり直す button
    const yarinaosuButton = screen.getByRole('button', { name: 'やり直す' });
    fireEvent.click(yarinaosuButton);

    // Click the modal's やり直す button
    const modalYarinaosuButton = screen.getByRole('button', { name: 'やり直す' });
    fireEvent.click(modalYarinaosuButton);

    // Wait for the API call to fail
    await waitFor(() => expect(mockedAxios.delete).toHaveBeenCalled());

    // Ensure an error message is displayed
    const errorMessage = screen.getByText('削除に失敗しました。もう一度お試しください。');
    expect(errorMessage).toBeInTheDocument();

    // Ensure the やり直す button is still visible
    expect(screen.getByRole('button', { name: 'やり直す' })).toBeInTheDocument();
  });
});
