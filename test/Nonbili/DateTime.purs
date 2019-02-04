module Test.Nonbili.DateTime where

import Nonbili.Prelude

import Data.Argonaut.Core as A
import Data.Argonaut.Decode (decodeJson)
import Jest (expectToEqual, test)
import Nonbili.DateTime (getUTCDate, getUTCTime)

spec :: Effect Unit
spec =
  test "DateTime" $ do
    let
      dateTime = decodeJson $ A.fromString "2019-02-04T01:47:50.052Z"
      date = getUTCDate <$> dateTime
      time = getUTCTime <$> dateTime
    expectToEqual date (Right { year: 2019.0, month: 2.0, day: 4.0 })
    expectToEqual time (Right { hour: 1.0, minute: 47.0 })
