module Main where

import "rio" RIO

import "dhall" Dhall (auto, detailed, input)
import "optparse-applicative" Options.Applicative
    ( Parser
    , ParserInfo
    , execParser
    , flag
    , help
    , helper
    , info
    , long
    , metavar
    , progDesc
    , strArgument
    )

import "purcel" Purcel
    ( DhallFile
    , Env(Env, envLogFunc, envReadPurcel)
    , Purcel
    )

import qualified "rio" RIO.Text.Lazy

import qualified "purcel" Purcel

main :: IO ()
main = do
  Options { debug, detailedErrors, dhallFile } <- execParser parserInfo
  runRIO (env debug detailedErrors) $ Purcel.main dhallFile

parserInfo :: ParserInfo Options
parserInfo =
  info
    (helper <*> options)
    (progDesc "Package manager for PureScript")

data Options
  = Options
    { debug          :: !Debug
    , detailedErrors :: !DetailedErrors
    , dhallFile      :: !DhallFile
    }

options :: Parser Options
options =
  Options
    <$> flag
      NoDebug
      YesDebug
      ( long "debug"
      <> help "Print debugging information"
      )
    <*> flag
      NoDetailedErrors
      YesDetailedErrors
      ( long "detailed"
      <> help "Print detailed errors from Dhall"
      )
    <*> strArgument
      ( metavar "DHALL_FILE"
      )

data DetailedErrors
  = NoDetailedErrors
  | YesDetailedErrors

data Debug
  = NoDebug
  | YesDebug

env :: Debug -> DetailedErrors -> Env
env debug detailedErrors = Env { envLogFunc, envReadPurcel }
  where
  envLogFunc cs source level str =
    withStickyLogger logOptions $ \f -> f cs source level str
    where
    logOptions = LogOptions
      { logMinLevel = case debug of
          NoDebug  -> LevelInfo
          YesDebug -> LevelDebug
      , logTerminal = True
      , logUseColor = True
      , logUseTime = False
      , logUseUnicode = True
      , logVerboseFormat = True
      }
  envReadPurcel :: DhallFile -> IO Purcel
  envReadPurcel = case detailedErrors of
    NoDetailedErrors  -> input auto . RIO.Text.Lazy.pack
    YesDetailedErrors -> detailed . input auto . RIO.Text.Lazy.pack
