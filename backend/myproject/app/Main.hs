-- https://qiita.com/niruneru/items/880bc1a0649c92a158aa

-- Copyright Masahiro Yamauchi (c) 2016

-- All rights reserved.

-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:

--     * Redistributions of source code must retain the above copyright
--       notice, this list of conditions and the following disclaimer.

--     * Redistributions in binary form must reproduce the above
--       copyright notice, this list of conditions and the following
--       disclaimer in the documentation and/or other materials provided
--       with the distribution.

--     * Neither the name of Masahiro Yamauchi nor the names of other
--       contributors may be used to endorse or promote products derived
--       from this software without specific prior written permission.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
-- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
-- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
-- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
-- OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
-- LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
-- DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
-- THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
-- OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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

indexView :: IO()
indexView = 
  top <- BS.readFile "../../client/index.html"
  run 8080 $ serve api (server top)

main :: IO ()
main = do
  args <- getArgs
  let arg1 = if (length args > 0) then Just (args !! 0) else indexView
  case arg1 of
    Just "migrate" -> doMigration
    _ -> run 8080 app
