{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import Servant
import Network.Wai.Handler.Warp
import Network.HTTP.Media ((//), (/:))
import qualified Data.ByteString.Lazy as BS
import Control.Monad.IO.Class (liftIO)

data HTML

instance Accept HTML where
    contentType _ = "text" // "html" /: ("charset", "utf-8")

instance MimeRender HTML BS.ByteString where
    mimeRender _ bs = bs

type API
    =    Get '[HTML] BS.ByteString
    :<|> "static" :> Raw

api :: Proxy API
api = Proxy

server :: BS.ByteString -> Server API
server top
    =    (liftIO $ return top)
    :<|> serveDirectoryWebApp "../../client"

main :: IO ()
main = do
  top <- BS.readFile "../../client/index.html"
  run 8080 $ serve api (server top)