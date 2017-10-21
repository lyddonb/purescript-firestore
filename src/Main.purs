module Main where

import Prelude
import Control.Monad.Aff (launchAff_)
import Control.Monad.Aff.Console (logShow)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION)
import Firestore (initializeApplication)
import Firestore.Auth (Email(Email), Password(Password), initializeAuth, signInWithEmailAndPassword)
import Firestore.Types (FIRESTORE)
import Config (firestoreConfig, email, password)


main :: forall e. Eff (err :: EXCEPTION, console :: CONSOLE, firestore :: FIRESTORE | e) Unit
main = launchAff_ do
  let c = firestoreConfig
  app <- liftEff $ initializeApplication c
  a <- liftEff $ initializeAuth 
  res <- signInWithEmailAndPassword a (Email email) (Password password)
  logShow res
