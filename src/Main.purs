module Main where

import Prelude

import Config (firestoreConfig, email, password)
import Control.Monad.Aff (Aff, launchAff_)
import Control.Monad.Aff.Console (logShow)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.State.Trans (StateT, evalStateT)
import Data.Maybe (Maybe)
import Firestore (initializeApplication)
import Firestore.Auth (class HasAuthentication, Email(Email), Password(Password), initializeAuth, signInWithEmailAndPassword)
import Firestore.Context (AuthdContext(AuthdContext))
import Firestore.Types (FIRESTORE)
import Firestore.User (User)


signIn 
  :: forall s eff . HasAuthentication s =>
   StateT s (Aff (firestore :: FIRESTORE | eff)) (Maybe User)
signIn = signInWithEmailAndPassword (Email email) (Password password)

main :: forall e. Eff (err :: EXCEPTION, console :: CONSOLE, firestore :: FIRESTORE | e) Unit
main = launchAff_ do
  let c = firestoreConfig
  app <- liftEff $ initializeApplication c
  a <- liftEff $ initializeAuth 
  res <- evalStateT signIn $ AuthdContext { application: app, auth: a }
  logShow res
