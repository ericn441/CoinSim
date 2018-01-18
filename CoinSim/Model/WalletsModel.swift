//
//  WalletsModel.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/14/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import Foundation
import SwiftyJSON

class WalletObject {
    
    var id: String
    var name: String
    var symbol: String
    var amountUSD: Double
    var amount: Double
    
    init(id: String, name: String, symbol: String, amountUSD: Double, amount: Double) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.amountUSD = amountUSD
        self.amount = amount
    }
}
