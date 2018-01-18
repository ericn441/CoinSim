//
//  DataStorage.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/14/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import Foundation
import RealmSwift

class Wallet: Object {
    
    //MARK: - Init
    convenience init(id: String, name: String, symbol: String, amount: Double, amountUSD: Double) {
        self.init()
        self.id = id
        self.name = name
        self.symbol = symbol
        self.amount = amount
        self.amountUSD = amountUSD
    }
    
    //MARK: - Presisted Properties
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var symbol = ""
    @objc dynamic var amount = 0.0
    @objc dynamic var amountUSD = 0.0
    
    //MARK: - Declare Primay Key
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //MARK: - Create Default USD Wallet
    private static func createUSDWallet(in realm: Realm) -> Wallet {
        let usdWallet = Wallet(id: "usd", name: "USD", symbol: "USD", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(usdWallet, update: true)
        }
        return usdWallet
    }
    
    @discardableResult
    static func defaultUSDWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "usd") ?? createUSDWallet(in: realm)
    }
    
    //MARK: - Create Default Bitcoin Wallet
    private static func createBitcoinWallet(in realm: Realm) -> Wallet {
        let bitcoinWallet = Wallet(id: "bitcoin", name: "Bitcoin", symbol: "BTC", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(bitcoinWallet, update: true)
        }
        return bitcoinWallet
    }
    
    @discardableResult
    static func defaultBitcoinWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "bitcoin") ?? createBitcoinWallet(in: realm)
    }
    
    //MARK: - Create Default Ethereum Wallet
    private static func createEthereumWallet(in realm: Realm) -> Wallet {
        let ethereumWallet = Wallet(id: "ethereum", name: "Ethereum", symbol: "ETC", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(ethereumWallet, update: true)
        }
        return ethereumWallet
    }
    
    @discardableResult
    static func defaultEthereumWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "ethereum") ?? createEthereumWallet(in: realm)
    }
    
    //MARK: - Create Default Ripple Wallet
    private static func createRippleWallet(in realm: Realm) -> Wallet {
        let rippleWallet = Wallet(id: "ripple", name: "Ripple", symbol: "XRP", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(rippleWallet, update: true)
        }
        return rippleWallet
    }
    
    @discardableResult
    static func defaultRippleWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "ripple") ?? createRippleWallet(in: realm)
    }
    
    //MARK: - Create Default Bitcoin Cash Wallet
    private static func createBitcoinCashWallet(in realm: Realm) -> Wallet {
        let bitcoinCashWallet = Wallet(id: "bitcoin-cash", name: "Bitcoin Cash", symbol: "BCH", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(bitcoinCashWallet, update: true)
        }
        return bitcoinCashWallet
    }
    
    @discardableResult
    static func defaultBitcoinCashWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "bitcoin-cash") ?? createBitcoinCashWallet(in: realm)
    }
    
    //MARK: - Create Default Litecoin Wallet
    private static func createLitecoinWallet(in realm: Realm) -> Wallet {
        let litecoinWallet = Wallet(id: "litecoin", name: "Litecoin", symbol: "LTC", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(litecoinWallet, update: true)
        }
        return litecoinWallet
    }
    
    @discardableResult
    static func defaultLitecoinWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "litecoin") ?? createLitecoinWallet(in: realm)
    }
    
    //MARK: - Create Default RaiBlocks Wallet
    private static func createRaiBlocksWallet(in realm: Realm) -> Wallet {
        let raiBlocksWallet = Wallet(id: "raiblocks", name: "RaiBlocks", symbol: "XRB", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(raiBlocksWallet, update: true)
        }
        return raiBlocksWallet
    }
    
    @discardableResult
    static func defaultRaiBlocksWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "raiblocks") ?? createRaiBlocksWallet(in: realm)
    }
    
    //MARK: - Create Default Monero Wallet
    private static func createMoneroWallet(in realm: Realm) -> Wallet {
        let moneroWallet = Wallet(id: "monero", name: "Monero", symbol: "XMR", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(moneroWallet, update: true)
        }
        return moneroWallet
    }
    
    @discardableResult
    static func defaultMoneroWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "monero") ?? createMoneroWallet(in: realm)
    }
    
    //MARK: - Create Default Stellar Wallet
    private static func createStellarWallet(in realm: Realm) -> Wallet {
        let stellarWallet = Wallet(id: "stellar", name: "Stellar", symbol: "XLM", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(stellarWallet, update: true)
        }
        return stellarWallet
    }
    
    @discardableResult
    static func defaultStellarWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "stellar") ?? createStellarWallet(in: realm)
    }
    
    //MARK: - Create Default IOTA Wallet
    private static func createIOTAWallet(in realm: Realm) -> Wallet {
        let iotaWallet = Wallet(id: "iota", name: "IOTA", symbol: "IOT", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(iotaWallet, update: true)
        }
        return iotaWallet
    }
    
    @discardableResult
    static func defaultIOTAWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "iota") ?? createIOTAWallet(in: realm)
    }
    
    //MARK: - Create Default NEO Wallet
    private static func createNEOWallet(in realm: Realm) -> Wallet {
        let neoWallet = Wallet(id: "neo", name: "NEO", symbol: "NEO", amount: 0.0, amountUSD: 0.0)
        try! realm.write {
            realm.add(neoWallet, update: true)
        }
        return neoWallet
    }
    
    @discardableResult
    static func defaultNEOWallet(in realm: Realm) -> Wallet {
        return realm.object(ofType: Wallet.self, forPrimaryKey: "neo") ?? createNEOWallet(in: realm)
    }
    
}

class TransactionRecord: Object {
    
    @objc dynamic var buyAmount = ""
    @objc dynamic var buyAmountUSD = ""
    @objc dynamic var buyCoinName = ""
    @objc dynamic var sellAmount = ""
    @objc dynamic var sellAmountUSD = ""
    @objc dynamic var sellCoinName = ""
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var date = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
