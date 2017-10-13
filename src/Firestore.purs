module Firestore where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Uncurried (EffFn1, runEffFn1)
import Firestore.Types (FIRESTORE, Application(..), Firestore(..), FirestoreConfig)
import Data.Newtype (class Newtype, unwrap)


foreign import initializeApplicationImpl
  :: forall eff
   . EffFn1 (firestore :: FIRESTORE | eff)
      FirestoreConfig
      Application

foreign import initializeFirestoreImpl
  :: forall eff. Eff (firestore :: FIRESTORE | eff) Firestore

-- | Initialize a Firebase/Firestore application
initializeApplication
  :: forall eff . FirestoreConfig
  -> Eff (firestore :: FIRESTORE | eff) Application
initializeApplication c =
  runEffFn1 initializeApplicationImpl c

-- | Initialize a Firestore instance
initializeFirestore
  :: forall eff . Eff (firestore :: FIRESTORE | eff) Firestore
initializeFirestore = initializeFirestoreImpl

getAppConfig :: Application -> FirestoreConfig
getAppConfig (Application app) = app.options

getApp :: forall f a . Newtype f  { app :: Application | a } => f -> Application
getApp x = (unwrap x).app
