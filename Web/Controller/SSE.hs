module Web.Controller.SSE where

import Web.Controller.Prelude
import Control.Concurrent
import Network.HTTP.Types (status200)
import Network.HTTP.Types.Header ( hContentType )
import Network.Wai
import qualified Data.ByteString.Builder as B
import qualified IHP.DBvent as DBEvent

instance Controller SSEController where
    
    action StreamPostsEvents =  withTableReadTracker do
        query @Post |> fetch
        DBEvent.respondDbEvent "posts_updated"
