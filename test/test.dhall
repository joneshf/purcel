    let purcel
        : ./Purcel.dhall 
        = { package =
              "test"
          , modules =
              [ { name = "Main", contents = ./Main.purs as Text } ]
          , dependencies =
                ./prelude.dhall .modules
              # ./console.dhall .modules
              # ./eff.dhall .modules
          }

in  purcel
