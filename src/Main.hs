{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Protolude
import Servant

import Data.Aeson

import Network.Wai.Handler.Warp

-- internal imports

import Models

-- data Transaction = Transaction
--                  { fromAccount :: Text
--                  , toAccount   :: Text
--                  , reason      :: Text
--                  , amount      :: Integer
--                  } deriving (Show, Generic)
instance ToJSON Transaction
instance FromJSON Transaction

type FinanceAPI = "transaction" :> Capture "id" Integer :> Get '[JSON] Transaction

server :: Server FinanceAPI
server = return . return $ Transaction "income" "grocery" "Bought food" 2036

app :: Application
app = serve (Proxy :: Proxy FinanceAPI) server

main :: IO ()
main = run 8080 app
