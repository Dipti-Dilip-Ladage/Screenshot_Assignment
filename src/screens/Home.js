import React, {useEffect, useState} from 'react';
import {
  Image,
  Text,
  TouchableOpacity,
  View,
  NativeModules,
  StyleSheet,
  NativeEventEmitter,
  Platform,
  Alert,
  ActivityIndicator,
} from 'react-native';
import {arrowUpImg, iconImg} from '../images';
import {getDeviceMACAddress, getDeviceName, getIMEI} from '../utils/utils';

const {ScreenshotModule, AppDelegate, ScreenshotDetector} = NativeModules;

const Home = () => {
  const [isScreenshotEnabled, setIsScreenshotEnabled] = useState();
  const [isLoading, setIsLoading] = useState(false);
  const [screenshotDetected, setScreenshotDetected] = useState(false);
  const [data, setData] = useState();
  const enableScreenshot = async () => {
    if (Platform.OS === 'ios') {
      AppDelegate.enableSecureMode();
    } else {
      ScreenshotModule.enableSecureMode();
    }
    callAPI('enable')
      .then(res => {
        setIsLoading(false);
      })
      .catch(error => {});
  };

  const disableScreenshot = async () => {
    if (Platform.OS === 'ios') {
      AppDelegate.disableSecureMode();
    } else {
      ScreenshotModule.disableSecureMode();
    }
    callAPI('disable')
      .then(res => {
        setIsLoading(false);
      })
      .catch(error => {});
  };

  // Get Public IP Address
  const getPublicIPAddress = async () => {
    try {
      const response = await fetch('https://api.ipify.org?format=json');
      const data = await response.json();
      return data.ip;
    } catch (error) {}
  };

  const callAPI = async status => {
    // request send device details to REST API
    setData({
      OS: Platform.OS,
      devicename: await getDeviceName(),
      deviceMACaddress: await getDeviceMACAddress(),
      IMEI: await getIMEI(),
      Location: '',
      PublicIPAddress: await getPublicIPAddress(),
      screenshotstatus: status,
    });
    const response = new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve('success');
      }, 5000);
    });
    return response;
  };
  const toggleScreenshotProtection = () => {
    setIsLoading(true);
    if (isScreenshotEnabled) {
      disableScreenshot();
    } else {
      enableScreenshot();
    }
    setIsScreenshotEnabled(!isScreenshotEnabled);
  };

  useEffect(() => {
    if (!ScreenshotDetector) {
      console.error('ScreenshotDetector is not available.');
      return;
    }
    const screenshotEventEmitter = new NativeEventEmitter(ScreenshotDetector);
    const subscription = screenshotEventEmitter.addListener(
      'ScreenshotDetected',
      () => {
        setScreenshotDetected(true);
        Alert.alert(
          'Screenshot Detected',
          'A screenshot has been taken!',
          [
            {
              text: 'OK',
              onPress: () => console.log('OK Pressed'),
            },
          ],
          {cancelable: false},
        );
        if (isScreenshotEnabled) {
          alert('Screenshot detected while in secure mode!');
        }
      },
    );
    return () => {
      subscription.remove();
      if (screenshotEventEmitter) {
        screenshotEventEmitter.removeAllListeners();
      }
    };
  }, [isScreenshotEnabled]);

  if (isLoading) {
    return (
      <View style={styles.container}>
        <ActivityIndicator />

        <Text style={{textAlign: 'center', marginHorizontal: 20}}>
          {'\nSending data.. please wait.. \n\n' + JSON.stringify(data)}
        </Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Image source={iconImg} style={styles.logoImg} />
      <TouchableOpacity
        style={styles.btnContainer}
        onPress={toggleScreenshotProtection}>
        <Image source={arrowUpImg} resizeMode="stretch" style={styles.btnImg} />
        <Text style={{color: 'white', fontSize: 12}}>
          {isScreenshotEnabled ? 'Activated' : 'Activate'}
        </Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  btnContainer: {
    backgroundColor: '#4624E3',
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: 8,
    paddingLeft: 8,
    paddingRight: 12,
    borderRadius: 20,
    marginTop: 80,

    shadowColor: '#4624E3', // IOS
    shadowOffset: {width: -2, height: 10},
    shadowOpacity: 0.2,
    shadowRadius: 3,
    elevation: 10, // Android
  },
  btnImg: {
    height: 20,
    width: 25,
    marginRight: 2,
  },
  logoImg: {width: 100, height: 100, borderRadius: 15},
});

export default Home;
