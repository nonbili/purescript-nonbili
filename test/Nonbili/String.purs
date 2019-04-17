module Test.Nonbili.String where

import Nonbili.Prelude

import Data.String as String
import Data.String.Regex as Regex
import Data.String.Regex.Flags as RegexFlags
import Data.String.Regex.Unsafe (unsafeRegex)
import Jest (test)
import Nonbili.String (padStart)
import Test.QuickCheck (quickCheck)

spec :: Effect Unit
spec =
  test "padStart" $ do
    let re = unsafeRegex "^0+$" RegexFlags.noFlags
    quickCheck \n s -> do
      let
        lengthDiff = n - String.length s
        { before, after } = String.splitAt lengthDiff $ padStart n s
      after == s && if lengthDiff <= 0
        then before == ""
        else Regex.test re before
