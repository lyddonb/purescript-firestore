"use strict";

const firebase = require("firebase");
// Required for side-effects
require("firebase/firestore");

exports.initializeApplicationImpl = function(config) {
  return firebase.initializeApp(config);
};

exports.initializeFirestoreImpl = function() {
  return firebase.firestore();
};
