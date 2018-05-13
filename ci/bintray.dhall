    let Config = { date : Text, tag : Text, tarFile : Text }

in    λ(config : Config)
    → { files =
          [ { includePattern = config.tarFile, uploadPattern = config.tarFile }
          ]
      , package =
          { licenses =
              [ "BSD 3-Clause" ]
          , name =
              "purcel"
          , repo =
              "generic"
          , subject =
              "joneshf"
          , vcs_url =
              "https://github.com/joneshf/purcel.git"
          }
      , version =
          { name = config.tag, released = config.date }
      }
