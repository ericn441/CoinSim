//
//  PriceModel.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/10/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import Foundation
import SwiftyJSON

class SharedCoinData { //Singleton Shared Instance
    static let shared = SharedCoinData()
    var dict = [String:CoinObject]()
}

class CoinObject {
    
    var id: String
    var name: String
    var symbol: String
    var priceUSD: String
    var volume: String
    var marketCap: String
    var priceChange: String
    
    init(id: String, name: String, symbol: String, priceUSD: String, volume: String, marketCap: String, priceChange: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.priceUSD = priceUSD
        self.volume = volume
        self.marketCap = marketCap
        self.priceChange = priceChange
    }
}

class CoinHistory {
    var ticker: String
    var name: String
    var time: Int
    var readableTime: String
    var closePrice: Double
    
    init(ticker: String, name: String, time: Int, readableTime: String, closePrice: Double) {
        self.ticker = ticker
        self.name = name
        self.time = time
        self.readableTime = readableTime
        self.closePrice = closePrice
    }
}

class PriceModel {
    func parseCoinData(json: JSON) -> CoinObject {
        var coinObject: CoinObject?
        
        for coins in json.arrayValue {
            coinObject = CoinObject(id: coins["id"].stringValue, name: coins["name"].stringValue, symbol: coins["symbol"].stringValue, priceUSD: coins["price_usd"].stringValue, volume: coins["24h_volume_usd"].stringValue, marketCap: coins["market_cap_usd"].stringValue, priceChange: coins["percent_change_24h"].stringValue)
        }
        
        return coinObject!
    }
    func parseHistoricalData(json: JSON, ticker: String, name: String) -> [CoinHistory] {
        var coinHistory: [CoinHistory] = []
        
        for results in json["Data"].arrayValue {
            coinHistory.append(CoinHistory(ticker: ticker, name: name, time: results["time"].intValue, readableTime: "", closePrice: results["close"].doubleValue))
        }
        return coinHistory
    }
    
}
