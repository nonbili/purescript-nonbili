module Nonbili.Prelude
  ( module Prelude
  , module CallByName.Applicative
  , module CallByName.Syntax
  , module Control.Alt
  , module Control.Monad.Except
  , module Control.MonadPlus
  , module Data.Array
  , module Data.Bifunctor
  , module Data.Const
  , module Data.Either
  , module Data.Foldable
  , module Data.Functor
  , module Data.Maybe
  , module Data.Newtype
  , module Data.Symbol
  , module Data.Traversable
  , module Data.Tuple
  , module Debug.Trace
  , module Effect
  , module Effect.Class
  , sym
  ) where

import Prelude hiding (when,unless)

import CallByName.Applicative (when, unless)
import CallByName.Syntax ((\\))
import Control.Alt ((<|>))
import Control.Monad.Except (except, runExcept)
import Control.MonadPlus (guard)
import Data.Array ((:), (..))
import Data.Bifunctor (lmap, rmap)
import Data.Const (Const(..))
import Data.Either (Either(..), either, hush, note)
import Data.Foldable (fold, foldl, foldr, for_, traverse_)
import Data.Functor (mapFlipped)
import Data.Maybe (Maybe(..), fromMaybe, isJust, isNothing, maybe)
import Data.Newtype (class Newtype, unwrap, wrap)
import Data.Symbol (SProxy(..))
import Data.Traversable (for, sequence, traverse)
import Data.Tuple (Tuple(..), uncurry)
import Debug.Trace (spy, trace, traceM)
import Effect (Effect)
import Effect.Class (liftEffect)

sym :: forall a. SProxy a
sym = SProxy
