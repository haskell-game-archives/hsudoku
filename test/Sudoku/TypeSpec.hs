module Sudoku.TypeSpec (main, spec) where

import Data.Maybe (fromJust, isJust)
import Sudoku.Type
import Test.Hspec
import Test.QuickCheck
import TestData

-- `main` is here so that this module can be run from GHCi on its own.  It is
-- -- not needed for automatic spec discovery.
main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  describe "toString" $ do
    it "should return a non empty string for a sudoku" $
      property $
        \(TS s) -> not (null (toString s))

  describe "fromString" $ do
    it "should not fail for already existing sudokus" $
      property $
        \(TS s) -> isJust (fromString $ toString s)

    it "should be inverse to toString" $
      property $
        \(TS s) -> (toString . fromJust . fromString . toString) s == toString s
