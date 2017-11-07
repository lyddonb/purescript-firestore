module Test.FirestoreSpec where

import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.State.Trans (evalStateT)
import Data.Lens (lens)
import Firestore (getAppConfig, getApp, getCurrentApp, deleteApp, initializeApplication, initializeFirestore)
import Firestore.Context (Context(Context))
import Firestore.Types (FIRESTORE, Application, class HasApplication)
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
          _ <- liftEff $ evalStateT deleteApp (Context { application: app })
          (getAppConfig app) `shouldEqual` c
    describe "Construct a firestore database" do
       it "returns a new firestore database" do
          let c = firestoreConfig
          app <- liftEff $ getCurrentApp 
          let ctx = Context { application: app }
          fsdb <- liftEff $ evalStateT initializeFirestore ctx
          _ <- liftEff $ evalStateT deleteApp ctx
          (getAppConfig $ getApp fsdb) `shouldEqual` c
