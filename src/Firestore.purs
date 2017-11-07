module Firestore where

import Control.Monad.Eff.Uncurried
import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Uncurried (EffFn1, runEffFn1)
import Control.Monad.State.Trans (StateT)
import Control.Monad.Trans.Class (lift)
import Data.Lens ((^.), use, Getter, view)
import Data.Newtype (class Newtype, unwrap)
import Firestore.Types (class HasApplication, FIRESTORE, Application(Application), Firestore, FirestoreConfig, _application)


foreign import initializeApplicationImpl
  :: forall eff
   . EffFn1 (firestore :: FIRESTORE | eff)
      FirestoreConfig
      Application

foreign import initializeFirestoreImpl
  :: forall eff. Eff (firestore :: FIRESTORE | eff) Firestore

foreign import getApplicationImpl
  :: forall eff. Eff (firestore :: FIRESTORE | eff) Application

foreign import deleteApplicationImpl
  :: forall eff.
   EffFn1 (firestore :: FIRESTORE | eff)
   Application
   Application

-- | Initialize a Firebase/Firestore application
initializeApplication
  :: forall eff . FirestoreConfig
  -> Eff (firestore :: FIRESTORE | eff) Application
initializeApplication c =
  runEffFn1 initializeApplicationImpl c

-- | Initialize a Firestore instance
initializeFirestore
  :: forall s eff . HasApplication s => 
   StateT s (Eff (firestore :: FIRESTORE | eff)) Firestore
initializeFirestore = lift $ initializeFirestoreImpl

getAppConfig :: Application -> FirestoreConfig
getAppConfig (Application app) = app.options

getApp :: forall f a . Newtype f  { app :: Application | a } => f -> Application
getApp x = (unwrap x).app

getCurrentApp :: forall eff. Eff (firestore :: FIRESTORE | eff) Application
getCurrentApp = getApplicationImpl

deleteApp :: forall s eff . HasApplication s =>
  StateT s (Eff (firestore :: FIRESTORE | eff)) Unit
deleteApp = do
  app <- use _application
  _ <- lift $ pure $ runEffFn1 deleteApplicationImpl app
  pure unit
