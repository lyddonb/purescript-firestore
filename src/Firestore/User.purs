module Firestore.User where

import Data.Foreign.NullOrUndefined (NullOrUndefined)
import Data.Generic.Rep as Rep
import Data.Generic.Rep.Show (genericShow)
import Data.Newtype (class Newtype)
import Simple.JSON (class ReadForeign)
import Prelude (class Eq, class Show)

newtype UserInfo = UserInfo
  { displayName :: NullOrUndefined String
  , email :: NullOrUndefined String
  , phoneNumber :: NullOrUndefined String
  , photoURL :: NullOrUndefined String
  , providerId :: String
  , uid :: String
  }

derive instance newtypeUserInfo :: Newtype UserInfo _
derive newtype instance rfUserInfo :: ReadForeign UserInfo
derive instance repGenericUserInfo :: Rep.Generic UserInfo _
derive instance eqUserInfo :: Eq UserInfo
instance showUserInfo :: Show UserInfo where
  show = genericShow

newtype User = User
  { displayName :: NullOrUndefined String
  , email :: NullOrUndefined String
  , emailVerified :: Boolean
  , isAnonymous :: Boolean
  , phoneNumber :: NullOrUndefined String
  , photoURL :: NullOrUndefined String
  , providerData :: Array UserInfo
  , providerId :: String
  , refreshToken :: String
  , uid :: String
  }

derive instance newtypeUser :: Newtype User _
derive newtype instance rfUser :: ReadForeign User
derive instance repGenericUser :: Rep.Generic User _
derive instance eqUser :: Eq User
instance showUser :: Show User where
  show = genericShow
