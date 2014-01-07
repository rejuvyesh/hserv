-- File: Main.hs
-- Copyright rejuvyesh <mail@rejuvyesh.com>, 2014

{-# LANGUAGE OverloadedStrings, DeriveDataTypeable #-}
module Main where

import Network.Wai.Application.Static
import Network.Wai.Handler.Warp
import System.Console.CmdArgs

data Hserv = Hserv
             { port :: Int
             }
             deriving (Data, Typeable)

main :: IO()
main = do
  hserv <- cmdArgs $ Hserv
           { port = 8888 &= help "Port on which server should run" &= opt (8888::Int) }
           &= summary "hserv 0.1"
  let p = port hserv
  putStrLn $ "Running hserv on port " ++ (show p)
  run p $ staticApp $ defaultFileServerSettings "."
