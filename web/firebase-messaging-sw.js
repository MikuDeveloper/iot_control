importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js");

// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyBOREjyC1ArM8E6j3VbzepMnqB7SP7fXeE",
  authDomain: "iot-control-e9084.firebaseapp.com",
  projectId: "iot-control-e9084",
  storageBucket: "iot-control-e9084.appspot.com",
  messagingSenderId: "662993512175",
  appId: "1:662993512175:web:1f5cd8af6d9bc8e63b5d1a",
  measurementId: "G-QYRLS0NLXL"
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

// todo Set up background message handler
messaging.onBackgroundMessage((message) => {
 console.log("onBackgroundMessage", message);
});