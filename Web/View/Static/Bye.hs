module Web.View.Static.Bye where
import Web.View.Prelude

data ByeView = ByeView

instance View ByeView where
    html ByeView = [hsx|
        <h1>Bye</h1>
         <a href={WelcomeAction}>To welcome</a>
|]