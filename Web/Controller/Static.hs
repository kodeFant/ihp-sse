module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Welcome

instance Controller StaticController where
    action WelcomeAction = do
        posts <- query @Post |> orderBy #createdAt |> fetch
        render WelcomeView {..}