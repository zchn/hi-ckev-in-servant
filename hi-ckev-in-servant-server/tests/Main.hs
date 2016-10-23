module Main
  ( main
  ) where

import Protolude

import Control.Monad.Log (Severity(..))
import Servant.QuickCheck
       ((<%>), createContainsValidLocation, defaultArgs, not500,
        notLongerThan, serverSatisfies,
        unauthorizedContainsWWWAuthenticate, withServantServer)
import Test.Tasty (defaultMain, TestTree, testGroup)
import Test.Tasty.Hspec (Spec, it, testSpec)

import HiCkevInServant.API (api)
import HiCkevInServant.Server (server)

main :: IO ()
main = defaultMain =<< tests

tests :: IO TestTree
tests = do
  specs <- testSpec "quickcheck tests" spec
  pure $ testGroup "HiCkevInServant.Server" [specs]

spec :: Spec
spec =
  it "follows best practices" $
  withServantServer api (pure (server Error)) $
  \burl ->
     serverSatisfies
       api
       burl
       defaultArgs
       (not500 <%> createContainsValidLocation <%> notLongerThan 100000000 <%> unauthorizedContainsWWWAuthenticate <%>
        mempty)