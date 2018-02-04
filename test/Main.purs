module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)

main :: Eff (console :: CONSOLE) Unit
main = log "hello world"
