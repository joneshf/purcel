let purcel : { package : Text
             , modules : List Text
             , dependencies : List ./Module.dhall
             }
           = { package = "test"
             , modules =
               [ "Main"
               ]
             , dependencies = (./prelude.dhall).modules
               # (./console.dhall).modules
               # (./eff.dhall).modules
             }
in
    purcel
