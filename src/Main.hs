{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
module Main where

import Protolude
import Servant

import GHC.Generics
import Data.Aeson
import Data.String

import Network.Wai
import Network.Wai.Handler.Warp

data Transaction = Transaction
                 { fromAccount :: String
                 , toAccount   :: String
                 , reason      :: String
                 , amount      :: Integer
                 } deriving (Show, Generic)
instance ToJSON Transaction
instance FromJSON Transaction

type FinanceAPI = "transaction" :> Capture "id" Integer :> Get '[JSON] Transaction

server :: Server FinanceAPI
server = return . return $ Transaction "income" "grocery" "Bought food" 2036

app :: Application
app = serve (Proxy :: Proxy FinanceAPI) server

main :: IO ()
main = run 8080 app
