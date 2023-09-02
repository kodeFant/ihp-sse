module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Posts
import Web.Controller.Static
import Web.Controller.SSE
import Network.Minio (SSE)
import Data.Semigroupoid.Static (Static)
import IHP.PGEventSource (initPgEventSource)

instance FrontController WebApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator Marker
        , parseRoute @PostsController
        , parseRoute @StaticController
        , parseRoute @SSEController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
        initPgEventSource


