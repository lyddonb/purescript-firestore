"use strict";

const firebase = require("firebase");
// Required for side-effects
require("firebase/firestore");

exports.initializeAuthImpl = function() {
  return firebase.auth();
};
