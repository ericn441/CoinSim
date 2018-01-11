//
//  PriceModel.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/10/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import Foundation
import SwiftyJSON

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

class PriceModel {
    func parseCoinData(json: JSON) -> CoinObject {
        var coinObject: CoinObject?
        
        for coins in json.arrayValue {
            coinObject = CoinObject(id: coins["id"].stringValue, name: coins["name"].stringValue, symbol: coins["symbol"].stringValue, priceUSD: coins["price_usd"].stringValue, volume: coins["24h_volume_usd"].stringValue, marketCap: coins["market_cap_usd"].stringValue, priceChange: coins["percent_change_24h"].stringValue)
        }
        
        return coinObject!
    }
    
}
