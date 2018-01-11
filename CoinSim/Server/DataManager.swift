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
    
    fileprivate static let baseURL = "https://api.coinmarketcap.com/"
    
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
                case .getBitcoinPrice:          return "/v1.0/ticker/bitcoin"
                case .getEthereumPrice:         return "/v1.0/ticker/ethereum"
                case .getRipplePrice:           return "/v1.0/ticker/ripple"
                case .getBitcoinCashPrice:      return "/v1.0/ticker/bitcoin-cash"
                case .getLitecoinPrice:         return "/v1.0/ticker/litecoin"
                case .getRaiBlocksPrice:        return "/v1.0/ticker/raiblocks"
                case .getMoneroPrice:           return "/v1.0/ticker/monero"
                case .getStellarPrice:          return "/v1.0/ticker/stellar"
                case .getIOTAPrice:             return "/v1.0/ticker/iota"
                case .getNEOPrice:              return "/v1.0/ticker/neo"
            }
        }
    }
    
    static func getAllCoinPrices(_ completionHandler: @escaping (JSON) -> ()) {
        
        //Coin URLs
        let btcURL = baseURL + ResourcePath.getBitcoinPrice.description
        let ethURL = baseURL + ResourcePath.getEthereumPrice.description
        let xrpURL = baseURL + ResourcePath.getRipplePrice.description
        let bccURL = baseURL + ResourcePath.getBitcoinCashPrice.description
        let ltcURL = baseURL + ResourcePath.getLitecoinPrice.description
        let xrbURL = baseURL + ResourcePath.getRaiBlocksPrice.description
        let xmrURL = baseURL + ResourcePath.getMoneroPrice.description
        let xlmURL = baseURL + ResourcePath.getStellarPrice.description
        let iotamURL = baseURL + ResourcePath.getIOTAPrice.description
        let neoURL = baseURL + ResourcePath.getNEOPrice.description
        
        let parameters: Parameters = [:]
        
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
