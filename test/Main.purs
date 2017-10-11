module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Firestore (FIRESTORE)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (RunnerEffects, run)
import Test.FirestoreSpec as FirestoreSpec

main :: forall e. Eff (RunnerEffects (console :: CONSOLE, firestore :: FIRESTORE | e)) Unit
main = run [consoleReporter] do
  FirestoreSpec.spec
