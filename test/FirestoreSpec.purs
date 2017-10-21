module Test.FirestoreSpec where

import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Firestore (getAppConfig, getApp, initializeApplication, initializeFirestore)
import Firestore.Types (FIRESTORE)
import Prelude (Unit, bind, discard, ($))
import Test.Config (firestoreConfig)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)


spec :: forall eff. Spec (firestore :: FIRESTORE, console :: CONSOLE | eff) Unit
spec = 
  describe "Firestore tests" do
    describe "Initialize application" do 
       it "returns an application when given a valid config" do
          let c = firestoreConfig
          app <- liftEff $ initializeApplication c
          (getAppConfig app) `shouldEqual` c
    describe "Construct a firestore database" do
       it "returns a new firestore database" do
          let c = firestoreConfig
          fsdb <- liftEff $ initializeFirestore
          (getAppConfig $ getApp fsdb) `shouldEqual` c
