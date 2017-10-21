module Firestore.Auth where

import Data.Generic.Rep as Rep
import Control.Monad.Aff (Aff)
import Control.Monad.Eff (Eff)
import Control.Monad.Except (runExcept)
import Control.Promise (toAff, Promise)
import Data.Either (Either, hush)
import Data.Foreign (Foreign, MultipleErrors)
import Data.Foreign.NullOrUndefined (NullOrUndefined)
import Data.Function.Uncurried (Fn3, runFn3)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe)
import Data.Newtype (class Newtype)
import Firestore.Types (FIRESTORE, Application)
import Firestore.User (User)
import Prelude (class Eq, class Show, bind, pure, ($), (<$>))
import Simple.JSON (class ReadForeign, read)


newtype Auth = Auth
  { app :: Application
  , languageCode :: NullOrUndefined String
  , currentUser :: NullOrUndefined User
  }

derive instance newtypeAuth :: Newtype Auth _
derive newtype instance rfAuth :: ReadForeign Auth
derive instance repGenericAuth :: Rep.Generic Auth _
derive instance eqAuth :: Eq Auth
instance showAuth :: Show Auth where
  show = genericShow

newtype Email = Email String
newtype Password = Password String

foreign import initializeAuthImpl
  :: forall eff. Eff (firestore :: FIRESTORE | eff) Auth

foreign import signInWithEmailAndPasswordImpl
  :: 
  Fn3
  Auth 
  String 
  String  
  (Promise Foreign)

-- | Initialize a Firestore auth instance
initializeAuth
  :: forall eff . Eff (firestore :: FIRESTORE | eff) Auth
initializeAuth = initializeAuthImpl

-- | Sign in with an email and password
signInWithEmailAndPassword'
  :: forall eff . 
   Auth -> Email -> Password -> Aff (firestore :: FIRESTORE | eff) (Either MultipleErrors User)
signInWithEmailAndPassword' a (Email em) (Password pwd) = do
  res <- toAff $ runFn3 signInWithEmailAndPasswordImpl a em pwd
  pure $ runExcept $ read res

-- | Sign in with an email and password
signInWithEmailAndPassword
  :: forall eff . 
   Auth -> Email -> Password -> Aff (firestore :: FIRESTORE | eff) (Maybe User)
signInWithEmailAndPassword a e p = hush <$> signInWithEmailAndPassword' a e p
