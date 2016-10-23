-- | Launch hi-ckev-in-servant server.
module Main
  ( main
  ) where

import Protolude

import HiCkevInServant.Server (startApp)

main :: IO ()
main = startApp
