import {Platform} from 'react-native';
import DeviceInfo from 'react-native-device-info';

// Get Device Name
export const getDeviceName = async () => {
  const deviceName = await DeviceInfo.getDeviceName();
  return deviceName;
};

export const getDeviceMACAddress = async () => {
  const macAddress = await DeviceInfo.getMacAddress();
  return macAddress;
};

// Get IMEI (Only for Android)
export const getIMEI = async () => {
  if (Platform.OS === 'android') {
    const imei = await DeviceInfo.getUniqueId();
    return imei;
  } else {
    return '';
  }
};
