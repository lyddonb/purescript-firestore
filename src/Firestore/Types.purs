module Firestore.Types where

import Control.Monad.Eff (kind Effect)
import Data.Generic (class Generic)
import Data.Generic.Rep as Rep
import Data.Generic.Rep.Show (genericShow)
import Data.Newtype (class Newtype)
import Simple.JSON (class ReadForeign)
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
derive newtype instance rfFirestoreConfig :: ReadForeign FirestoreConfig
derive instance repGenericFirestoreConfig :: Rep.Generic FirestoreConfig _
derive instance eqFirestoreConfig :: Eq FirestoreConfig
instance showFirestoreConfig :: Show FirestoreConfig where
  show = genericShow

newtype Application = Application
  { options :: FirestoreConfig
  }

derive instance genericApplication :: Generic Application
derive newtype instance rfApplication :: ReadForeign Application
derive instance repGenericApplication :: Rep.Generic Application _
derive instance eqApplication :: Eq Application
instance showApplication :: Show Application where
  show = genericShow

newtype Firestore = Firestore
  { app :: Application
  }

derive instance newtypeFirestore :: Newtype Firestore _
derive newtype instance rfFirestore :: ReadForeign Firestore
derive instance repGenericFirestore :: Rep.Generic Firestore _
derive instance eqFirestore :: Eq Firestore
instance showFirestore :: Show Firestore where
  show = genericShow
