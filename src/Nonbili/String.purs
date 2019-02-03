module Nonbili.String
  ( padStart
  ) where

import Nonbili.Prelude

import Data.Array as Array
import Data.String as String
import Data.String.CodeUnits (fromCharArray)

padStart :: Int -> String -> String
padStart targetLength input =
  fromCharArray (Array.replicate padLength '0') <> input
  where
  padLength = max (targetLength - String.length input) 0
