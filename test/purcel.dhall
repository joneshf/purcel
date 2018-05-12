    let snapshot =
          ../snapshot/2018-02-04-16-12-56 sha256:f27c194932f31195723bacb5179813df0774fcee8baedffacf06aa338eab8eda 

in  let purcel
        : ../types/Purcel 
        = { package =
              "test"
          , modules =
              [ { name = "Main", contents = ./Main.purs as Text } ]
          , dependencies =
              snapshot.modules
          }

in  purcel
