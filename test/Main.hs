module Main where

import "rio" RIO

import "dhall" Dhall (auto, detailed, input)

import "purcel" Purcel (DhallFile, Env(Env, envLogFunc, envReadPurcel), Purcel)

import qualified "rio" RIO.Text.Lazy

import qualified "purcel" Purcel

main :: IO ()
main = runRIO env $ Purcel.main "./test/purcel.dhall"

env :: Env
env = Env { envLogFunc, envReadPurcel }
  where
  envLogFunc cs source level str =
    withStickyLogger logOptions $ \f -> f cs source level str
    where
    logOptions = LogOptions
      { logMinLevel = LevelInfo
      , logTerminal = True
      , logUseColor = True
      , logUseTime = False
      , logUseUnicode = True
      , logVerboseFormat = True
      }
  envReadPurcel :: DhallFile -> IO Purcel
  envReadPurcel = detailed . input auto . RIO.Text.Lazy.pack
