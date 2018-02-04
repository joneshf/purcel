module Main where

import "rio" RIO

main :: IO ()
main = runRIO devEnv main'

main' :: (HasLogFunc env) => RIO env ()
main' = do
  logInfo "hello world"

data Env
  = Env
    { envLogFunc :: !LogFunc
    }

instance HasLogFunc Env where
  logFuncL = to envLogFunc

devEnv :: Env
devEnv = Env { envLogFunc }
  where
  envLogFunc cs source level str =
    withStickyLogger options $ \f -> f cs source level str
    where
    options = LogOptions
      { logMinLevel = LevelDebug
      , logTerminal = True
      , logUseColor = True
      , logUseTime = False
      , logUseUnicode = True
      , logVerboseFormat = True
      }
