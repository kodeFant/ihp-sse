module Application.Helper.Partials where

import IHP.ViewPrelude
import Generated.Types
import Web.Types
import Web.Routes

printPosts :: [Post] -> Html
printPosts posts = [hsx|
    <ul>
        {forEach posts printPost}
    </ul>
|]

printPost :: Post -> Html
printPost post = 
    [hsx|
    <li>
        <header></header>
        <div><strong>{post.nickname}:</strong> {post.content}</div>
        <button hx-delete={DeletePostAction post.id} hx-swap="none">Delete</button>
    </li>
    |]
