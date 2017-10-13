module Firestore.Types where

import Control.Monad.Eff (kind Effect)
import Data.Generic (class Generic, gShow)
import Data.Newtype (class Newtype)
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

derive instance newtypeFirestore :: Newtype Firestore _
derive instance genericFirestore :: Generic Firestore
derive instance eqFirestore :: Eq Firestore
instance showFirestore :: Show Firestore where
    show = gShow
