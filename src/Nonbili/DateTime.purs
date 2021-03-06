module Nonbili.DateTime
  ( DateTime(..)
  , Milliseconds(..)
  , Date
  , Time
  , now
  , getDate
  , getTime
  , getUTCDate
  , getUTCTime
  ) where

import Nonbili.Prelude

import Data.Argonaut.Core as A
import Data.Argonaut.Decode (class DecodeJson, JsonDecodeError(..))
import Data.Argonaut.Encode (class EncodeJson, encodeJson)
import Data.JSDate (JSDate)
import Data.JSDate as JSDate
import Data.Time.Duration as DT
import Effect.Unsafe (unsafePerformEffect)

newtype DateTime = DateTime JSDate
derive instance eqDateTime :: Eq DateTime
derive instance ordDateTime :: Ord DateTime

instance decodeJsonDateTime :: DecodeJson DateTime where
  decodeJson json =
    note (UnexpectedValue json)
         (A.toString json >>= read)

instance encodeJsonDateTime :: EncodeJson DateTime where
  encodeJson (DateTime date) =
    if JSDate.isValid date
    then
      A.fromString $ unsafePerformEffect $ JSDate.toISOString date
    else
      A.jsonNull

read :: String -> Maybe DateTime
read str =
  if JSDate.isValid date
  then pure $ DateTime date
  else Nothing
  where
  date = unsafePerformEffect $ JSDate.parse str

now :: Effect DateTime
now = DateTime <$> JSDate.now

newtype Milliseconds = Milliseconds DT.Milliseconds
derive instance eqMilliseconds :: Eq Milliseconds
derive instance ordMilliseconds :: Ord Milliseconds

instance decodeJsonMilliseconds :: DecodeJson Milliseconds where
  decodeJson json =
    note (UnexpectedValue json)
         (Milliseconds <<< DT.Milliseconds <$> A.toNumber json)

instance encodeJsonMilliseconds :: EncodeJson Milliseconds where
  encodeJson (Milliseconds (DT.Milliseconds ms)) = encodeJson ms

type Date =
  { year :: Number
  , month :: Number
  , day :: Number
  }

type Time =
  { hour :: Number
  , minute :: Number
  }

-- getMonth count from 0
getDate :: DateTime -> Effect Date
getDate (DateTime date) = do
  year <- JSDate.getFullYear date
  month <- JSDate.getMonth date
  day <- JSDate.getDate date
  pure { year, month: month + 1.0, day }

getTime :: DateTime -> Effect Time
getTime (DateTime date) = do
  hour <- JSDate.getHours date
  minute <- JSDate.getMinutes date
  pure { hour, minute }

-- getMonth count from 0
getUTCDate :: DateTime -> Date
getUTCDate (DateTime date) = do
  let
    year = JSDate.getUTCFullYear date
    month = JSDate.getUTCMonth date
    day = JSDate.getUTCDate date
  { year, month: month + 1.0, day }

getUTCTime :: DateTime -> Time
getUTCTime (DateTime date) = do
  let
    hour = JSDate.getUTCHours date
    minute = JSDate.getUTCMinutes date
  { hour, minute }
