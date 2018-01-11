//
//  PricesViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/10/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit
import MXParallaxHeader

class PricesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MXParallaxHeaderDelegate {
    
    //MARK: - UI Componets
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Coin Data
    var coins: [String:CoinObject] = [:]
    var coinsLoaded: [String:Bool] = ["bitcoin":false, "ethereum":false, "ripple":false, "bitcoinCash":false, "litecoin":false, "raiblocks": false, "monero":false, "stellar":false, "iota":false, "neo":false]
 
    //MARK: - TableView Coin Representation
    struct RenderableCoin {
        var coinName: String!
        var coinPrice: String!
        var coinTicker: String!
        var coinIcon: UIImage!
        var priceChange: String!
        var tradeVolume: String!
        var marketCap: String!
    }
    var renderableCoinsArray: [RenderableCoin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parallax Header
        tableView.parallaxHeader.view = headerView // You can set the parallax header view from the floating view
        tableView.parallaxHeader.height = 150
        tableView.parallaxHeader.mode = MXParallaxHeaderMode.fill
        tableView.parallaxHeader.delegate = self
        
        //Fetch Coin Prices
        fetchAllCoinPrices()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.parallaxHeader.minimumHeight = topLayoutGuide.length
    }
    //MARK: - Helper functions
    func fetchAllCoinPrices() {
        
        //Flip load flags
        for (key, _) in coinsLoaded {
            coinsLoaded[key] = false
        }
        
        //Append each coin
        DataManager.getBitcoinPrice { (JSON) in
            self.coins["bitcoin"] = PriceModel().parseCoinData(json: JSON)
            self.coinsLoaded["bitcoin"] = true
            self.compileCoinData()
        }
        DataManager.getEthereumPrice { (JSON) in
            self.coins["ethereum"] = PriceModel().parseCoinData(json: JSON)
            self.coinsLoaded["ethereum"] = true
            self.compileCoinData()
        }
        DataManager.getRipplePrice { (JSON) in
            self.coins["ripple"] = PriceModel().parseCoinData(json: JSON)
            self.coinsLoaded["ripple"] = true
            self.compileCoinData()
        }
        DataManager.getBitcoinCashPrice { (JSON) in
            self.coins["bitcoinCash"] = PriceModel().parseCoinData(json: JSON)
            self.coinsLoaded["bitcoinCash"] = true
            self.compileCoinData()
        }
        DataManager.getLitecoinPrice { (JSON) in
            self.coins["litecoin"] = PriceModel().parseCoinData(json: JSON)
            self.coinsLoaded["litecoin"] = true
            self.compileCoinData()
        }
        DataManager.getRaiBlocksPrice { (JSON) in
            self.coins["raiblocks"] = PriceModel().parseCoinData(json: JSON)
            self.coinsLoaded["raiblocks"] = true
            self.compileCoinData()
        }
        DataManager.getMoneroPrice { (JSON) in
            self.coins["monero"] = PriceModel().parseCoinData(json: JSON)
            self.coinsLoaded["monero"] = true
            self.compileCoinData()
        }
        DataManager.getStellarPrice { (JSON) in
            self.coins["stellar"] = PriceModel().parseCoinData(json: JSON)
            self.coinsLoaded["stellar"] = true
            self.compileCoinData()
        }
        DataManager.getIotaPrice { (JSON) in
            self.coins["iota"] = PriceModel().parseCoinData(json: JSON)
            self.coinsLoaded["iota"] = true
            self.compileCoinData()
        }
        DataManager.getNeoPrice { (JSON) in
            self.coins["neo"] = PriceModel().parseCoinData(json: JSON)
            self.coinsLoaded["neo"] = true
            self.compileCoinData()
        }
    }
    func compileCoinData() {
        var totalLoadedCoins = 0
        
        //Count how many coins loaded from the api
        for (_, value) in coinsLoaded {
            if value == true {
                totalLoadedCoins += 1
            }
        }
        
        //Execute only if all coins have loaded
        if totalLoadedCoins == 10 {
            for (_, value) in coins {
                renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: value.symbol, coinIcon: UIImage(named: "wallets-tab-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
            }
            self.tableView.reloadData()
        }
        
    }
    
    //MARK: - UITableView Protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return renderableCoinsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as! PricesTableViewCell
        
        //Round card corners
        cell.cardView.layer.cornerRadius = 5
        cell.cardView.layer.masksToBounds = true
        
        //Disable cell highlight
        cell.selectionStyle = .none
        
        //Coin Name
        cell.coinName.text = renderableCoinsArray[indexPath.row].coinName
        
        //Coin Price
        cell.coinPrice.text = "$" + renderableCoinsArray[indexPath.row].coinPrice
        
        //Coin Ticker
        cell.coinTicker.text = renderableCoinsArray[indexPath.row].coinTicker
        
        //Price Change
        if renderableCoinsArray[indexPath.row].priceChange.contains("-") {
            cell.priceChange.textColor = .red
        } else {
            cell.priceChange.textColor = .green
        }
        cell.priceChange.text = "(\(renderableCoinsArray[indexPath.row].priceChange!)%)"
        
        //Trade Volume
        cell.tradeVolume.text = "24hr Trade Volume - $\(renderableCoinsArray[indexPath.row].tradeVolume!)"
        
        //Market Cap
        cell.marketCap.text = "Total Market Cap - $\(renderableCoinsArray[indexPath.row].marketCap!)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

class PricesTableViewCell: UITableViewCell {
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var coinTicker: UILabel!
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var priceChange: UILabel!
    @IBOutlet weak var tradeVolume: UILabel!
    @IBOutlet weak var marketCap: UILabel!
    @IBOutlet weak var cardView: UIView!
    
}
