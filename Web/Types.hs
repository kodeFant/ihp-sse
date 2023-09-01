module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction
                      deriving (Eq, Show, Data)

data SSEController 
    = StreamPostsEvents
    deriving (Eq, Show, Data)


data PostsController
    = PostsAction
    | CreatePostAction
    | DeletePostAction { postId :: !(Id Post) }
    deriving (Eq, Show, Data)
