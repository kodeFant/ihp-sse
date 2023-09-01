module Web.View.Static.Welcome where
import Web.View.Prelude
import Application.Helper.Partials (printPosts)

data WelcomeView = WelcomeView { posts :: [Post]}

instance View WelcomeView where
    html WelcomeView{..} = [hsx|
    <h1>HTMX/SSE-chat</h1>
    <div class="row">
    <form class="col">
        <p>
            <label class="form-label" for="nickname">Your nickname</label>
            <input class="form-control" id="nickname" name="nickname" required  />
        </p>
        <p>
            <label class="form-label"  for="content">Title</label>
            <textarea class="form-control" id="content" name="content" required  rows="5" />
        </p>
        <button hx-post={pathTo CreatePostAction} hx-swap="none" hx-include="closest form" type="submit">Submit</button>
    </form>
        <div class="col" hx-ext="sse" {...[("sse-connect", pathTo StreamPostsEvents)]}>
            <div hx-get={PostsAction} hx-trigger="sse:posts_updated">
                {printPosts posts}
            </div>
        </div>
    </div>


|]
