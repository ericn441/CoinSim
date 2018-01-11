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
    
    fileprivate enum ResourcePath: CustomStringConvertible {
        
        case getBitcoinPrice                // returns btc price
        case getEthereumPrice               // returns eth price
        case getRipplePrice                 // returns xrp price
        case getBitcoinCashPrice            // returns bcc price
        case getLitecoinPrice               // returns ltc price
        case getRaiBlocksPrice              // retruns xrb price
        case getMoneroPrice                 // returns xmr price
        case getStellarPrice                // returns xlm price
        case getIOTAPrice                   // returns miota price
        case getNEOPrice                    // retruns neo price
        
        var description: String {
            switch self {
                case .getBitcoinPrice:          return "/v1/ticker/bitcoin"
                case .getEthereumPrice:         return "/v1/ticker/ethereum"
                case .getRipplePrice:           return "/v1/ticker/ripple"
                case .getBitcoinCashPrice:      return "/v1/ticker/bitcoin-cash"
                case .getLitecoinPrice:         return "/v1/ticker/litecoin"
                case .getRaiBlocksPrice:        return "/v1/ticker/raiblocks"
                case .getMoneroPrice:           return "/v1/ticker/monero"
                case .getStellarPrice:          return "/v1/ticker/stellar"
                case .getIOTAPrice:             return "/v1/ticker/iota"
                case .getNEOPrice:              return "/v1/ticker/neo"
            }
        }
    }
    
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
    static func getRaiBlocksPrice(_ completionHandler: @escaping (JSON) -> ()) {
        let parameters: Parameters = [:]
        let xrbURL = baseURL + ResourcePath.getRaiBlocksPrice.description
        
        //RaiBlocks
        Alamofire.request(xrbURL, method: .get, parameters: parameters).responseJSON{ response in
            guard response.result.error == nil else {
                print("error calling GET RaiBlocks")
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
    
}
