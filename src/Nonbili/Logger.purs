module Nonbili.Logger
  ( logDebug
  , logInfo
  , logWarn
  , logError
  ) where

import Nonbili.Prelude

import Data.JSDate as JsDate
import Effect.Class (class MonadEffect)
import Effect.Class.Console as Console

data LogLevel
  = LevelDebug
  | LevelInfo
  | LevelWarn
  | LevelError

instance showLogLevel :: Show LogLevel where
  show = case _ of
    LevelDebug -> "Debug"
    LevelInfo -> "Info"
    LevelWarn -> "Warn"
    LevelError -> "Error"

logger :: forall m. MonadEffect m => LogLevel -> (String -> m Unit)
logger = case _ of
  LevelDebug -> Console.log
  LevelInfo -> Console.info
  LevelWarn -> Console.warn
  LevelError -> Console.error

log :: forall m. MonadEffect m => LogLevel -> String -> m Unit
log level msg = liftEffect do
  time <- JsDate.now >>= JsDate.toISOString
  (logger level) $ time <> " [" <> show level <> "] " <>msg

logDebug :: forall m. MonadEffect m => String -> m Unit
logDebug = log LevelDebug

logInfo :: forall m. MonadEffect m => String -> m Unit
logInfo = log LevelInfo

logWarn :: forall m. MonadEffect m => String -> m Unit
logWarn = log LevelWarn

logError :: forall m. MonadEffect m => String -> m Unit
logError = log LevelError
