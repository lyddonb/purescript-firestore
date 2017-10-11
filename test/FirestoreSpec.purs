module Test.FirestoreSpec where

import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Firestore (FIRESTORE, FirestoreConfig(..), getAppConfig, getFirestoreApp, initializeApplication, initializeFirestore)
import Prelude (Unit, bind, discard, ($), (<<<))
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)


testConfig :: FirestoreConfig
testConfig = FirestoreConfig
  { apiKey: "dummykey"
  , authDomain: "notreal.notfirebaseapp.com"
  , databaseURL: "https://notreal.notfirebaseio.com"
  , projectId: "notreal"
  , storageBucket: "notarealbucket"
  , messagingSenderId: "12345"
  }

spec :: forall eff. Spec (firestore :: FIRESTORE, console :: CONSOLE | eff) Unit
spec = 
  describe "Firestore tests" do
    describe "Initialize application" do 
       it "returns an application when given a valid config" do
          let c = testConfig
          app <- liftEff $ initializeApplication c
          (getAppConfig app) `shouldEqual` c
    describe "Construct a firestore database" do
       it "returns a new firestore database" do
          let c = testConfig
          fsdb <- liftEff $ initializeFirestore
          (getAppConfig $ getFirestoreApp fsdb) `shouldEqual` c
