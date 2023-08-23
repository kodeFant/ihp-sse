module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction
                      | ByeAction
                      deriving (Eq, Show, Data)

data SSEController = StreamEventsAction deriving (Eq, Show, Data)