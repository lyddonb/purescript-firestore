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

exports.deleteApplicationImpl = function(app) {
  var x = firebase.apps[0].delete();
  firebase.apps.pop();
  firebase.apps = [];
  return x;
};

exports.getApplicationImpl = function() {
  return firebase.apps[0];
};
