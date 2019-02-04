module Test.Main where

import Nonbili.Prelude

import Test.Nonbili.String as TestString
import Test.Nonbili.DateTime as TestDateTime

main :: Effect Unit
main = do
  TestString.spec
  TestDateTime.spec
