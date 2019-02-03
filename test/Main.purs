module Test.Main where

import Nonbili.Prelude

import Test.Nonbili.String as TestString

main :: Effect Unit
main = do
  TestString.spec
