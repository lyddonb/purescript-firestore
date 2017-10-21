module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Firestore.Types (FIRESTORE)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (RunnerEffects, run)
import Test.FirestoreSpec as FirestoreSpec
import Test.Firestore.AuthSpec as FirestoreAuthSpec

main :: forall e. Eff (RunnerEffects (console :: CONSOLE, firestore :: FIRESTORE | e)) Unit
main = run [consoleReporter] do
  FirestoreSpec.spec
  FirestoreAuthSpec.spec
