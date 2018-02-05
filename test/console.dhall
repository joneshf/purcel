let purcel : { package : Text
             , modules : List ./Module.dhall
             , dependencies : List ./Module.dhall
             }
           = { package = "console"
             , modules =
               [ { name = "Control/Monad/Eff/Console.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-console/v3.0.0/src/Control/Monad/Eff/Console.js as Text
                 }
               , { name = "Control/Monad/Eff/Console.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-console/v3.0.0/src/Control/Monad/Eff/Console.purs as Text
                 }
               ]
             , dependencies = (./prelude.dhall).modules
               # (./eff.dhall).modules
             }
in
    purcel
