{-# LANGUAGE DeriveGeneric #-}
module Types where

import Protolude
import Data.Aeson
import Database.PostgreSQL.Simple

data Transaction = Transaction
                 { fromAccount :: Text
                 , toAccount   :: Text
                 , reason      :: Text
                 , amount      :: Integer
                 } deriving (Show, Generic)
instance ToJSON Transaction
instance FromJSON Transaction
instance FromRow Transaction
instance ToRow Transaction
