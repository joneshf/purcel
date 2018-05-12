    let purcel
        : ../types/Purcel
        = { package =
              "test"
          , modules =
              [ { name = "Main", contents = ./Main.purs as Text } ]
          , dependencies =
                ../purcel/prelude .modules
              # ../purcel/console .modules
              # ../purcel/eff .modules
          }

in  purcel
