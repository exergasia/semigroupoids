{-# LANGUAGE CPP #-}
-- | Placeholders for missing instances of Traversable, until base catches up and adds them
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Data.Traversable.Instances where

#if (!(MIN_VERSION_base(4,7,0)) || !(MIN_VERSION_transformers(0,3,0)))
import Data.Foldable
import Data.Traversable
#if !(MIN_VERSION_transformers(0,3,0))
import Control.Monad.Trans.Identity
#endif

#if !(MIN_VERSION_transformers(0,3,0))
instance Foldable m => Foldable (IdentityT m) where
  foldMap f = foldMap f . runIdentityT

instance Traversable m => Traversable (IdentityT m) where
  traverse f = fmap IdentityT . traverse f . runIdentityT
#endif

#if !(MIN_VERSION_base(4,7,0))
instance Foldable ((,) a) where
  foldMap f (_, x) = f x

instance Traversable ((,) a) where
  traverse f (a, b) = (,) a <$> f b
#endif

#endif