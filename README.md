# created enable/disable screenshot functionality without npm library for both android and iOS

## run project by below steps :-

## step 1:-

- [npm install]()-> will create node_modules folder

## step 2:-

- [cd android]()-> got to android folder
- [./gradlew clean]()-> clean the gradle
- [cd ..]()-> go back
- [npx react-native start --reset-cache]()-> reset cache and start server
- [npm run android]()-> will run android app

## step 3:-

- [cd ios]()-> navigate to ios folder
- [pod install]()-> will install pod library in iOS app
- [npm run ios]()-> will run iOS app

# description of assignment done

- Added RAKBANK logo and button to toggle screenshot functionality, used bridge concept here to achive screenshot enable/disable functionality.

- created functions in respected android and iOS files and called this native functions in react native code base using NativeBase.

- on button click showing loader on screen also printed data request in JSON format on screen, created async function and created data requests to pass in REST api

- used setTimeout function, added delay and handled loader according to settimeout start and end
