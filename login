import React from 'react';

interface OutlineButtonProps {
    title: string;
    onClick: () => void;
}

const OutlineButton: React.FC<OutlineButtonProps> = ({ title, onClick }) => {
    return (
        <button style={styles.button} onClick={onClick}>
            {title}
        </button>
    );
};

const styles = {
    button: {
        width: '295px',
        height: '52px',
        borderRadius: '26px',
        backgroundColor: '#FFFFFF',
        border: '1px solid #429AD0',
        color: '#429AD0',
        fontSize: '16px',
        cursor: 'pointer',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
    } as React.CSSProperties,
};

export default OutlineButton;
import React from 'react';
import { TouchableOpacity, Text, StyleSheet } from 'react-native';

interface FilledButtonProps {
    title: string;
    onPress: () => void;
}

const FilledButton: React.FC<FilledButtonProps> = ({ title, onPress }) => {
    return (
        <TouchableOpacity style={styles.button} onPress={onPress}>
            <Text style={styles.buttonText}>{title}</Text>
        </TouchableOpacity>
    );
};

const styles = StyleSheet.create({
    button: {
        width: 295,
        height: 52,
        borderRadius: 26,
        backgroundColor: '#429AD0', // Sea Blue
        justifyContent: 'center',
        alignItems: 'center',
    },
    buttonText: {
        fontSize: 16,
        color: '#FFFFFF', // White text on blue background
    },
});

export default FilledButton;
