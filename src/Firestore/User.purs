module Firestore.User where

import Data.Generic (class Generic, gShow)
import Data.Maybe (Maybe)
import Prelude (class Eq, class Show)

newtype UserInfo = UserInfo
  { displayName :: Maybe String
  , email :: Maybe String
  , phoneNumber :: Maybe String
  , photoURL :: Maybe String
  , providerId :: String
  , uid :: String
  }

derive instance genericUserInfo :: Generic UserInfo
derive instance eqUserInfo :: Eq UserInfo
instance showUserInfo :: Show UserInfo where
    show = gShow

newtype User = User
  { displayName :: Maybe String
  , email :: Maybe String
  , emailVerified :: Boolean
  , isAnonymous :: Boolean
  , phoneNumber :: Maybe String
  , photoURL :: Maybe String
  , providerData :: Array UserInfo
  , providerId :: String
  , refreshToken :: String
  , uid :: String
  }

derive instance genericUser :: Generic User
derive instance eqUser :: Eq User
instance showUser :: Show User where
    show = gShow
