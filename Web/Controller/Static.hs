module Web.Controller.Static where
import Web.Controller.Prelude
import Web.View.Static.Welcome
import Web.View.Static.Bye

instance Controller StaticController where
    action WelcomeAction = render WelcomeView
    action ByeAction = render ByeView
