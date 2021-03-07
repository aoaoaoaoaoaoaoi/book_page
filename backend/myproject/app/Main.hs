{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import Servant
import Network.Wai.Handler.Warp
import Network.HTTP.Media ((//), (/:))
import qualified Data.ByteString.Lazy as BS

data HTML

instance Accept HTML where
    contentType _ = "text" // "html" /: ("charset", "utf-8")

instance MimeRender HTML BS.ByteString where
    mimeRender _ bs = bs

type API = Get '[HTML] BS.ByteString

api :: Proxy API
api = Proxy

server :: BS.ByteString -> Server API
server top = return top

main :: IO ()
main = do
  top <- BS.readFile "../../client/index.html"
  run 8080 $ serve api (server top)