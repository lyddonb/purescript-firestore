module Test.Firestore.AuthSpec where

import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Firestore (getApp, getAppConfig)
import Firestore.Auth (initializeAuth)
import Firestore.Types (FIRESTORE, FirestoreConfig(..))
import Prelude (Unit, bind, discard, ($), (<<<))
import Test.Data (testConfig)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)


spec :: forall eff. Spec (firestore :: FIRESTORE, console :: CONSOLE | eff) Unit
spec = 
  describe "Firestore auth tests" do
    describe "Initialize auth" do 
       it "returns an Auth" do
         let c = testConfig
         a <- liftEff $ initializeAuth 
         (getAppConfig $ getApp a) `shouldEqual` c
