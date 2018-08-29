module Purcel where

import "rio" RIO
import "rio" RIO.FilePath ((</>))

import "dhall" Dhall (Interpret)

import qualified "rio" RIO.FilePath

main ::
  (HasLogFunc env, HasReadPurcel env, HasWriteModules env) =>
  DhallFile ->
  RIO env ()
main dhallFile = do
  logDebug "Reading Dhall file and fetching dependencies"
  Purcel { dependencies } <- readPurcel dhallFile
  logDebug "Writing dependencies to files"
  writeModules dependencies (RIO.FilePath.takeDirectory dhallFile </> ".purcel")

data Purcel
  = Purcel
    { package      :: !Text
    , dependencies :: ![Module]
    , modules      :: ![Module]
    }
  deriving (Generic)

instance Interpret Purcel

data Module
  = Module
    { name    :: !Text
    , contents :: !Text
    }
  deriving (Generic)

instance Interpret Module

type DhallFile = FilePath

type ReadPurcel = DhallFile -> IO Purcel

class HasReadPurcel env where
  readPurcelL :: SimpleGetter env ReadPurcel

readPurcel ::
  forall env f.
  (HasReadPurcel env, MonadIO f, MonadReader env f) =>
  DhallFile ->
  f Purcel
readPurcel dhall = do
  f <- view readPurcelL
  liftIO $ f dhall

type PurcelDirectory = FilePath

type WriteModules = [Module] -> PurcelDirectory -> IO ()

class HasWriteModules env where
  writeModulesL :: SimpleGetter env WriteModules

writeModules ::
  forall env f.
  (HasWriteModules env, MonadIO f, MonadReader env f) =>
  [Module] ->
  PurcelDirectory ->
  f ()
writeModules modules directory = do
  f <- view writeModulesL
  liftIO $ f modules directory

data Env
  = Env
    { envLogFunc    :: !LogFunc
    , envReadPurcel :: !ReadPurcel
    , envWriteModules :: !WriteModules
    }

instance HasLogFunc Env where
  logFuncL f env = (\envLogFunc -> env {envLogFunc}) <$> f (envLogFunc env)

instance HasReadPurcel Env where
  readPurcelL = to envReadPurcel

instance HasWriteModules Env where
  writeModulesL = to envWriteModules
