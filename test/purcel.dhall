    let snapshot =
          ../snapshot/2018-07-14-04-13-09.dhall sha256:19e0ad3504853705ff545e07558a6d4b1145aeb9f4dcdc5ed136bb80ff4f47fb

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
