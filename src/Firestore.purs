module Firestore where

import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Uncurried (EffFn1, runEffFn1)
import Data.Generic (class Generic, gShow)
import Prelude (class Eq, class Show)


-- | The effect associated with using the Firestore module
foreign import data FIRESTORE :: Effect

newtype FirestoreConfig = FirestoreConfig
  { apiKey :: String
  , authDomain :: String
  , databaseURL :: String
  , projectId :: String
  , storageBucket :: String
  , messagingSenderId :: String
  }

derive instance genericFirestoreConfig :: Generic FirestoreConfig
derive instance eqFirestoreConfig :: Eq FirestoreConfig
instance showFirestoreConfig :: Show FirestoreConfig where
    show = gShow

newtype Application = Application
  { options :: FirestoreConfig
  }

derive instance genericApplication :: Generic Application
derive instance eqApplication :: Eq Application
instance showApplication :: Show Application where
    show = gShow

newtype Firestore = Firestore
  { app :: Application
  }

derive instance genericFirestore :: Generic Firestore
derive instance eqFirestore :: Eq Firestore
instance showFirestore :: Show Firestore where
    show = gShow

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

getFirestoreApp :: Firestore -> Application
getFirestoreApp (Firestore fs) = fs.app
