import React from 'react';
import { TouchableOpacity, Text, StyleSheet } from 'react-native';

interface OutlineButtonProps {
    title: string;
    onPress: () => void;
}

const OutlineButton: React.FC<OutlineButtonProps> = ({ title, onPress }) => {
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
        backgroundColor: '#FFFFFF',
        borderWidth: 1,
        borderColor: '#429AD0', // Sea Blue
        justifyContent: 'center',
        alignItems: 'center',
    },
    buttonText: {
        fontSize: 16,
        color: '#429AD0', // Sea Blue
    },
});

export default OutlineButton;
