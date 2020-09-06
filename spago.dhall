{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "nonbili"
, dependencies =
  [ "aff"
  , "argonaut-codecs"
  , "arrays"
  , "call-by-name"
  , "console"
  , "const"
  , "debug"
  , "effect"
  , "either"
  , "jest"
  , "js-date"
  , "prelude"
  , "psci-support"
  , "quickcheck"
  , "strings"
  , "transformers"
  , "tuples"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
