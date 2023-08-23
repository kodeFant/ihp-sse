module Web.Controller.SSE where

import Web.Controller.Prelude
import Control.Concurrent
import Network.HTTP.Types (status200)
import Network.HTTP.Types.Header
import Network.Wai
import qualified Data.ByteString.Builder as B

instance Controller SSEController where
    
    action StreamEventsAction = do
        let headers = 
                [ ("Cache-Control", "no-store")
                , ("Connection", "keep-alive")
                , (hContentType, "text/event-stream")
                ]
        
        let streamBody sendChunk flush = do
                sendChunk (B.stringUtf8 "data: Connection established!\n\n") >> flush
                forever $ do
                    threadDelay (3 * 1000000)
                    sendChunk (B.stringUtf8 "data: Hello world\n\n") >> flush

                
        respondAndExit $ responseStream status200 headers streamBody
