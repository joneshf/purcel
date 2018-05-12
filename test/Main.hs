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
main = do
  (_, logOptions) <- logOptionsMemory
  withLogFunc logOptions $ \logFunc ->
    runRIO (env logFunc) $ Purcel.main "./test/purcel.dhall"

env :: LogFunc -> Env
env envLogFunc = Env { envLogFunc, envReadPurcel, envWriteModules }
  where
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
