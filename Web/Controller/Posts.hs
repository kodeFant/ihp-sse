module Web.Controller.Posts where

import Web.Controller.Prelude
import qualified Application.Helper.Partials as Partials

-- In this case, the PostsController is manly just an HTMX controller where the PostsAction responds with an hsx template instead of rendering a whole page.

instance Controller PostsController where
    action PostsAction = do
        posts <- query @Post |> orderBy #createdAt |> fetch
        respondHtml $ Partials.printPosts posts

    action CreatePostAction = do
        let post = newRecord @Post
        post
            |> buildPost
            |> ifValid \case
                Left post -> error "Error builidng post"
                Right post -> do
                    post <- post |> createRecord
                    renderPlain "ok"

    action PostsCountAction = do
        postsLength <- query @Post |> fetchCount
        renderPlain $ postsLength |> show |> cs

    action DeletePostAction { postId } = do
        post <- fetch postId
        deleteRecord post
        renderPlain "ok"

buildPost post = post
    |> fill @["nickname", "content"]
