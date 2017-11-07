module Firestore.Context where

import Data.Lens (lens)
import Firestore.Auth (Auth, class HasAuthentication)
import Firestore.Types (Application, class HasApplication)

data Context
  = Context { application :: Application }

instance authdContextHasApplication :: HasApplication Context where
  _application = lens (
    \(Context x) -> (x.application)) (\d x -> Context { application: x })

data AuthdContext
  = AuthdContext { application :: Application
                 , auth :: Auth
                 }

instance contextHasApplication :: HasApplication AuthdContext where
  _application = lens (\(AuthdContext x) -> (x.application)) (
    \(AuthdContext c) x -> AuthdContext (c { application = x }))

instance contextHasAuthenticaion :: HasAuthentication AuthdContext where
  _authentication = lens (\(AuthdContext x) -> (x.auth)) (
    \(AuthdContext c) x -> AuthdContext (c { auth = x }))
