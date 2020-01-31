module Nonbili.String
  ( padStart
  , search
  , startsWith
  , endsWith
  ) where

import Nonbili.Prelude

import Data.Array as Array
import Data.String (Pattern(..))
import Data.String as String
import Data.String.CodeUnits (fromCharArray)

padStart :: Int -> String -> String
padStart targetLength input =
  fromCharArray (Array.replicate padLength '0') <> input
  where
  padLength = max (targetLength - String.length input) 0

search :: Pattern -> Array String -> Array String
search (Pattern term) options =
  Array.sortWith (\p -> String.indexOf pattern $ String.toLower p) $
    Array.filter (\p -> String.contains pattern $ String.toLower p) options
  where
  pattern = String.Pattern $ String.toLower term

startsWith :: Pattern -> String -> Boolean
startsWith (Pattern p) str =
  String.take (String.length p) str == p

endsWith :: Pattern -> String -> Boolean
endsWith (Pattern p) str =
  String.drop (String.length str - String.length p) str == p
