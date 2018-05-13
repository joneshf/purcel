    let snapshot =
          ../snapshot/2018-05-12-17-15-57 sha256:225701da7b1fa7eb7d3b2e55a63fc0aafec2963bc4d6c0e6b9cafb2530668583 

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
