module Test.Nonbili.String where

import Nonbili.Prelude

import Data.String (Pattern(..))
import Data.String as String
import Data.String.Regex as Regex
import Data.String.Regex.Flags as RegexFlags
import Data.String.Regex.Unsafe (unsafeRegex)
import Jest (expectToBeFalse, expectToBeTrue, expectToEqual, test)
import Nonbili.String (padStart, search, startsWith, endsWith)
import Test.QuickCheck (quickCheck)

spec :: Effect Unit
spec = do
  test "padStart" $ do
    let re = unsafeRegex "^0+$" RegexFlags.noFlags
    quickCheck \n s -> do
      let
        lengthDiff = n - String.length s
        { before, after } = String.splitAt lengthDiff $ padStart n s
      after == s && if lengthDiff <= 0
        then before == ""
        else Regex.test re before

  test "search" $ do
    expectToEqual (search (Pattern "re") ["Haskell", "PureScript", "Regex", "Web"])
      ["Regex", "PureScript"]

    expectToEqual (search (Pattern "") ["Haskell", "PureScript", "Regex", "Web"])
      ["Haskell", "PureScript", "Regex", "Web"]

    expectToEqual (search (Pattern "abc") ["Haskell", "PureScript", "Regex", "Web"])
      []

  test "startsWith" $ do
    expectToBeTrue $ startsWith (Pattern "Pure") "PureScript"
    expectToBeTrue $ startsWith (Pattern "") "PureScript"
    expectToBeTrue $ startsWith (Pattern "") ""
    expectToBeFalse $ startsWith (Pattern "Pure") "Regex"

  test "endsWith" $ do
    expectToBeTrue $ endsWith (Pattern "Script") "PureScript"
    expectToBeTrue $ endsWith (Pattern "") "PureScript"
    expectToBeTrue $ endsWith (Pattern "") ""
    expectToBeFalse $ endsWith (Pattern "Pure") "Regex"
