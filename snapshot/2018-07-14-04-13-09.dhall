    let Module =
          https://raw.githubusercontent.com/joneshf/purcel/9e9d7971376286279ba60c8b05aa7c9a0a9fcafb/types/Module sha256:fdbf6b6946b08d54994df30e3f1ca1950a3125dfb5b1e59b34b116d392cd4310

in  let Purcel =
          https://raw.githubusercontent.com/joneshf/purcel/9e9d7971376286279ba60c8b05aa7c9a0a9fcafb/types/Purcel sha256:b8f167ea7bdc067c6e9bbd7540fba0114ebef28b21c139d1631f5c7ec1afed1b

in  let purcels =
          { console =
              ./../purcel/console sha256:857894f8ad02e262414cdeff2db4b170cc692c1f93d6f2ae9e7e149708c99023
          , eff =
              ./../purcel/eff sha256:715ad5c6982781d6ba766a4c4b57647bcb3d4e6781e76ff2d78b30c0d393b676
          , prelude =
              ./../purcel/prelude sha256:b8af105298a175878b838ae703844a4024e22d697ce8e55bf0c5b0b065e6329f
          }

in  let snapshot
        : Purcel
        = { package =
              "temp"
          , modules =
                  purcels.console.modules
                # purcels.eff.modules
                # purcels.prelude.modules
              : List Module
          , dependencies =
              [] : List Module
          }

in  snapshot
