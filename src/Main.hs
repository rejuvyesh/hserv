-- File: Main.hs
-- Copyright rejuvyesh <mail@rejuvyesh.com>, 2014

{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE OverloadedStrings  #-}
module Main where

import           Network.Wai.Application.Static (defaultFileServerSettings,
                                                 staticApp)
import           Network.Wai.Handler.Warp       (run)
import           System.Console.CmdArgs         (Data, Typeable, cmdArgs, help,
                                                 opt, summary, (&=))

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
  putStrLn $ "Go to http://0.0.0.0:" ++ (show p)
  run p $ staticApp $ defaultFileServerSettings "."
