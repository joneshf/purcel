let purcel : { package : Text
             , modules : List ./Module.dhall
             , dependencies : List ./Module.dhall
             }
           = { package = "eff"
             , modules =
               [ { name = "Control/Monad/Eff.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-eff/v3.1.0/src/Control/Monad/Eff.js as Text
                 }
               , { name = "Control/Monad/Eff.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-eff/v3.1.0/src/Control/Monad/Eff.purs as Text
                 }
               , { name = "Control/Monad/Eff/Class.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-eff/v3.1.0/src/Control/Monad/Eff/Class.purs as Text
                 }
               , { name = "Control/Monad/Eff/Uncurried.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-eff/v3.1.0/src/Control/Monad/Eff/Uncurried.js as Text
                 }
               , { name = "Control/Monad/Eff/Uncurried.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-eff/v3.1.0/src/Control/Monad/Eff/Uncurried.purs as Text
                 }
               , { name = "Control/Monad/Eff/Unsafe.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-eff/v3.1.0/src/Control/Monad/Eff/Unsafe.js as Text
                 }
               , { name = "Control/Monad/Eff/Unsafe.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-eff/v3.1.0/src/Control/Monad/Eff/Unsafe.purs as Text
                 }
               ]
             , dependencies = (./prelude.dhall).modules
             }
in
    purcel
