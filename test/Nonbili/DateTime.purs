module Test.Nonbili.DateTime where

import Nonbili.Prelude

import Data.Argonaut.Core as A
import Data.Argonaut.Decode (decodeJson)
import Data.Argonaut.Encode (encodeJson)
import Data.Either (isLeft)
import Jest (expectToBeTrue, expectToEqual, test)
import Nonbili.DateTime (getUTCDate, getUTCTime)

spec :: Effect Unit
spec = do
  test "Valid DateTime" $ do
    let
      isoString = "2019-02-04T01:47:50.052Z"
      dateTime = decodeJson $ A.fromString isoString
      date = getUTCDate <$> dateTime
      time = getUTCTime <$> dateTime
    expectToEqual date (Right { year: 2019.0, month: 2.0, day: 4.0 })
    expectToEqual time (Right { hour: 1.0, minute: 47.0 })

    let json = encodeJson <$> dateTime
    expectToEqual (A.toString <$> json) (Right $ Just isoString)

  test "Invalid DateTime" $ do
    let
      str = "abc"
      dateTime = decodeJson $ A.fromString str
      date = getUTCDate <$> dateTime
    expectToBeTrue $ isLeft dateTime
    expectToBeTrue $ isLeft date
