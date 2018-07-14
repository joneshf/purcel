module Main where

import "rio" RIO
import "rio" RIO.FilePath ((</>))

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
    , Env(Env, envLogFunc, envReadPurcel, envWriteModules)
    , Module(Module, contents, name)
    , Purcel
    , PurcelDirectory
    )

import qualified "rio" RIO.Directory
import qualified "rio" RIO.FilePath
import qualified "rio" RIO.Text

import qualified "purcel" Purcel

main :: IO ()
main = do
  Options { debug, detailedErrors, dhallFile } <- execParser parserInfo
  logOptions <- logOptionsHandle stderr (debug == YesDebug)
  withLogFunc logOptions $ \logFunc ->
    runRIO (env logFunc detailedErrors) $ Purcel.main dhallFile

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
  deriving (Eq)

env :: LogFunc -> DetailedErrors -> Env
env envLogFunc detailedErrors = Env { envLogFunc, envReadPurcel, envWriteModules }
  where
  envReadPurcel :: DhallFile -> IO Purcel
  envReadPurcel = case detailedErrors of
    NoDetailedErrors  -> input auto . RIO.Text.pack
    YesDetailedErrors -> detailed . input auto . RIO.Text.pack
  envWriteModules :: [Module] -> PurcelDirectory -> IO ()
  envWriteModules modules = for_ modules . writeModule
    where
    writeModule :: PurcelDirectory -> Module -> IO ()
    writeModule directory Module {contents, name} = do
      let directories = RIO.FilePath.takeDirectory $ RIO.Text.unpack name
      liftIO $ RIO.Directory.createDirectoryIfMissing True (directory </> directories)
      writeFileUtf8 (directory </> RIO.Text.unpack name) contents
