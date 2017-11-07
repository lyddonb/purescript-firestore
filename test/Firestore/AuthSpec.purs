module Test.Firestore.AuthSpec where

import Prelude

import Control.Monad.Aff (Aff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.State.Trans (StateT, evalStateT)
import Data.Foreign.NullOrUndefined (NullOrUndefined(NullOrUndefined))
import Data.Maybe (Maybe(..))
import Firestore (getApp, getAppConfig, getCurrentApp)
import Firestore.Auth (class HasAuthentication, Email(Email), Password(Password), initializeAuth, signInWithEmailAndPassword)
import Firestore.Context (AuthdContext(AuthdContext))
import Firestore.Types (FIRESTORE)
import Firestore.User (User(User))
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (fail, shouldEqual)
import Test.Config (firestoreConfig, email, password)


shouldEqualWithText :: forall r t. Show t => Eq t => String -> t -> t -> Aff r Unit
shouldEqualWithText mess v1 v2 =
  when (v1 /= v2) $ fail $ mess <> ": " <> show v1 <> " ≠ " <> show v2

verifyUser :: forall r. Maybe User -> Aff r Unit
verifyUser Nothing = fail "User returned Nothing"
verifyUser (Just (User u)) = do
  _ <- shouldEqualWithText "Email" u.email (NullOrUndefined (Just email))
  _ <- shouldEqualWithText "Display Name" u.displayName (NullOrUndefined Nothing)
  _ <- shouldEqualWithText "EmailVerified" u.emailVerified false
  _ <- shouldEqualWithText "IsAnonymouse" u.isAnonymous false
  _ <- shouldEqualWithText "PhoneNumber" u.phoneNumber (NullOrUndefined Nothing)
  shouldEqualWithText "PhotoURL" u.photoURL (NullOrUndefined Nothing)

spec :: forall eff. Spec (firestore :: FIRESTORE, console :: CONSOLE | eff) Unit
spec = 
  describe "Firestore auth tests" do
    describe "Initialize auth" do 
       it "returns an Auth" do
         let c = firestoreConfig
         a <- liftEff $ initializeAuth 
         (getAppConfig $ getApp a) `shouldEqual` c
    describe "Sign in with email and password" do 
      it "returns a logged in user" do
         app <- liftEff $ getCurrentApp 
         a <- liftEff $ initializeAuth 
         let ctx = AuthdContext { application: app, auth: a }
         result <- evalStateT signInTest ctx
         verifyUser result

signInTest
  :: forall s eff . HasAuthentication s =>
   StateT s (Aff (firestore :: FIRESTORE | eff)) (Maybe User)
signInTest = signInWithEmailAndPassword (Email email) (Password password)
