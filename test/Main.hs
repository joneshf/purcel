module Main where

import "rio" RIO
import "rio" RIO.FilePath ((</>))

import "dhall" Dhall (auto, detailed, input)

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
import qualified "rio" RIO.Text.Lazy

import qualified "purcel" Purcel

main :: IO ()
main = runRIO env $ Purcel.main "./test/purcel.dhall"

env :: Env
env = Env { envLogFunc, envReadPurcel, envWriteModules }
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
  envWriteModules :: [Module] -> PurcelDirectory -> IO ()
  envWriteModules modules = for_ modules . writeModule
    where
    writeModule :: PurcelDirectory -> Module -> IO ()
    writeModule directory Module {contents, name} = do
      let directories = RIO.FilePath.takeDirectory $ RIO.Text.unpack name
      liftIO $ RIO.Directory.createDirectoryIfMissing True (directory </> directories)
      writeFileUtf8 (directory </> RIO.Text.unpack name) contents
