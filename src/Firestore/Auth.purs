module Firestore.Auth where

import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe)
import Data.Newtype (class Newtype)
import Data.Generic (class Generic, gShow)
import Firestore.Types (FIRESTORE, Application)
import Firestore.User (User)
import Prelude (class Eq, class Show)


newtype Auth = Auth
  { app :: Application
  , languageCode :: Maybe String
  , currentUser :: Maybe User
  }

derive instance newtypeFirestore :: Newtype Auth _
derive instance genericAuth :: Generic Auth
derive instance eqAuth :: Eq Auth
instance showAuth :: Show Auth where
    show = gShow

foreign import initializeAuthImpl
  :: forall eff. Eff (firestore :: FIRESTORE | eff) Auth

-- | Initialize a Firestore auth instance
initializeAuth
  :: forall eff . Eff (firestore :: FIRESTORE | eff) Auth
initializeAuth = initializeAuthImpl
