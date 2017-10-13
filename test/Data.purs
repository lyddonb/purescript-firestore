module Test.Data where

import Firestore.Types (FirestoreConfig(..))

testConfig :: FirestoreConfig
testConfig = FirestoreConfig
  { apiKey: "dummykey"
  , authDomain: "notreal.notfirebaseapp.com"
  , databaseURL: "https://notreal.notfirebaseio.com"
  , projectId: "notreal"
  , storageBucket: "notarealbucket"
  , messagingSenderId: "12345"
  }
