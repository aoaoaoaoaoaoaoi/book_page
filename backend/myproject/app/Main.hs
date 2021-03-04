{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE TypeOperators #-}

import Data.Aeson
import GHC.Generics
import qualified Network.Wai.Handler.Warp as Warp
import System.Environment (getArgs)
import Servant

type API = "test" :> "all" :> Get '[JSON] [Test]

api :: Proxy API
api = Proxy

data Test = Test
  { test  :: String
  } deriving (Generic, ToJSON)

server :: Server API
server = pure [Test "testです"]

main :: IO ()
main = do
  Warp.run 18080 (serve api server)