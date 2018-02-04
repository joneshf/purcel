module Purcel where

import "rio" RIO

import "dhall" Dhall (Interpret)

main :: (HasLogFunc env, HasReadPurcel env) => DhallFile -> RIO env ()
main dhallFile = do
  logDebug "Reading Dhall file and fetching dependencies"
  _ <- readPurcel dhallFile
  logDebug "Writing dependencies to files"

data Purcel
  = Purcel
    { package      :: !Text
    , dependencies :: ![Module]
    , modules      :: ![Text]
    }
  deriving (Generic)

instance Interpret Purcel

data Module
  = Module
    { name     :: !Text
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

data Env
  = Env
    { envLogFunc    :: !LogFunc
    , envReadPurcel :: !ReadPurcel
    }

instance HasLogFunc Env where
  logFuncL = to envLogFunc

instance HasReadPurcel Env where
  readPurcelL = to envReadPurcel
