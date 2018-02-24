//
//  DataManager.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/10/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct DataManager {
    
    fileprivate static let baseURL = "https://api.coinmarketcap.com"
    fileprivate static let historicalBaseURL = "https://min-api.cryptocompare.com"
    
    fileprivate enum ResourcePath: CustomStringConvertible {
        
        //Coin Prices
        case getBitcoinPrice                // returns btc price
        case getEthereumPrice               // returns eth price
        case getRipplePrice                 // returns xrp price
        case getBitcoinCashPrice            // returns bcc price
        case getLitecoinPrice               // returns ltc price
        case getNanoPrice                   // retruns nano price
        case getMoneroPrice                 // returns xmr price
        case getStellarPrice                // returns xlm price
        case getIOTAPrice                   // returns miota price
        case getNEOPrice                    // retruns neo price
        
        //Historical Data
        case get30DayPrice                  // returns historical data for 30 days
        
        var description: String {
            switch self {
                
                //Coin Routes
                case .getBitcoinPrice:          return "/v1/ticker/bitcoin"
                case .getEthereumPrice:         return "/v1/ticker/ethereum"
                case .getRipplePrice:           return "/v1/ticker/ripple"
                case .getBitcoinCashPrice:      return "/v1/ticker/bitcoin-cash"
                case .getLitecoinPrice:         return "/v1/ticker/litecoin"
                case .getNanoPrice:             return "/v1/ticker/nano"
                case .getMoneroPrice:           return "/v1/ticker/monero"
                case .getStellarPrice:          return "/v1/ticker/stellar"
                case .getIOTAPrice:             return "/v1/ticker/iota"
                case .getNEOPrice:              return "/v1/ticker/neo"
                
                //Historical Data Routes
                case .get30DayPrice:            return "/data/histoday"
            }
        }
    }
    
    //MARK: - Get Coin Prices
    static func getBitcoinPrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let btcURL = baseURL + ResourcePath.getBitcoinPrice.description

        //Bitcoin
        Alamofire.request(btcURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET bitcoin")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
    }
    static func getEthereumPrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let ethURL = baseURL + ResourcePath.getEthereumPrice.description

        //Ethereum
        Alamofire.request(ethURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET ethereum")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
    }
    static func getRipplePrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let xrpURL = baseURL + ResourcePath.getRipplePrice.description

        //Ripple
        Alamofire.request(xrpURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET Ripple")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
        
    }
    static func getBitcoinCashPrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let bccURL = baseURL + ResourcePath.getBitcoinCashPrice.description

        //Bitcoin Cash
        Alamofire.request(bccURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET Bitcoin Cash")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
    }
    static func getLitecoinPrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let ltcURL = baseURL + ResourcePath.getLitecoinPrice.description

        //Litecoin
        Alamofire.request(ltcURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET Litecoin")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
    }
    static func getNanoPrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let nanoURL = baseURL + ResourcePath.getNanoPrice.description
        
        //Nano
        Alamofire.request(nanoURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET Nano")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
    }
    static func getMoneroPrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let xmrURL = baseURL + ResourcePath.getMoneroPrice.description

        //Monero
        Alamofire.request(xmrURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET Monero")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
    }
    static func getStellarPrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let xlmURL = baseURL + ResourcePath.getStellarPrice.description

        //Stellar
        Alamofire.request(xlmURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET Stellar")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
        
    }
    static func getIotaPrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let iotamURL = baseURL + ResourcePath.getIOTAPrice.description

        //IOTA
        Alamofire.request(iotamURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET IOTA")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
    }
    static func getNeoPrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let neoURL = baseURL + ResourcePath.getNEOPrice.description

        //NEO
        Alamofire.request(neoURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET NEO")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
    }
    
    //MARK: - Get Historical Data
    static func getHistoricalPrice(_ ticker:String, completionHandler: @escaping (JSON) -> ()) {
        var tickerSymbol = ticker
        if tickerSymbol == "NANO" {
            tickerSymbol = "XRB"
        }
        
        let parameters: Parameters = ["fsym":tickerSymbol.uppercased(), "tsym":"USD", "limit":"30"]
        let historicalURL = historicalBaseURL + ResourcePath.get30DayPrice.description
        
        Alamofire.request(historicalURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET historicalPrice")
                let data = JSON(response.result.error as Any)
                completionHandler(data)
                return
            }
            if let value: AnyObject = response.result.value as AnyObject? {
                let data = JSON(value)
                completionHandler(data)
            }
        }
    }
}
