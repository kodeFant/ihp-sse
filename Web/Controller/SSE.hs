module Web.Controller.SSE where

import Web.Controller.Prelude
import Control.Concurrent
import Network.HTTP.Types (status200)
import Network.HTTP.Types.Header
import qualified Data.UUID.V4 as UUID
import qualified Data.UUID as UUID
import qualified Network.Wai as Wai
import qualified Network.Wai.Internal as Wai
import qualified Data.ByteString.Builder as B
import qualified IHP.PGListener as PGListener
import IHP.ApplicationContext
import Network.Wai.EventSource (eventSourceAppIO, ServerEvent(..))
import qualified Control.Exception as Exception
import qualified Control.Concurrent.MVar as MVar
import qualified Data.Binary.Builder as ByteString
import qualified Data.Text as Text
import IHP.LocalRefresh

instance Controller SSEController where
    action StreamEventsAction = localRefresh do
        let headers = 
                [ ("Cache-Control", "no-store")
                , ("Connection", "keep-alive")
                , (hContentType, "text/event-stream")
                ]
        
        let streamBody sendChunk flush = do
                sendChunk (B.stringUtf8 "data: Connection established!\n\n") >> flush
                forever $ do
                    threadDelay (3 * 1000000)
                    -- TODO: Eventually replace with :heartbeat
                    sendChunk (B.stringUtf8 "data: Hello world\n\n") >> flush

                
        respondAndExit $ Wai.responseStream status200 headers streamBody
