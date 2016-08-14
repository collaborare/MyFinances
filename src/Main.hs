{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Protolude
import Servant

import Network.Wai.Handler.Warp

import Types

type FinanceAPI = "transaction" :> QueryParam "id" Integer :> Get '[JSON] Transaction

server :: Server FinanceAPI
server = return getTransaction 
  where getTransaction = return $ Transaction "income" "grocery" "Bought food" 2036

app :: Application
app = serve (Proxy :: Proxy FinanceAPI) server

main :: IO ()
main = run 8080 app
