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
    @IBOutlet var walletValue: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var refreshCtrl: UIRefreshControl!
    
    //MARK: - Coin Data
    var coins: [String:CoinObject] = [:]
    var coinsLoaded: [String:Bool] = ["bitcoin":false, "ethereum":false, "ripple":false, "bitcoinCash":false, "litecoin":false, "raiblocks": false, "monero":false, "stellar":false, "iota":false, "neo":false]

    //MARK: - Historical Data
    var selectedCoinData: CoinObject = CoinObject(id: "", name: "", symbol: "", priceUSD: "", volume: "", marketCap: "", priceChange: "")
    var selectedCoinPriceHistory: [CoinHistory] = []
    
    //MARK: - TableView Coin Representation Data
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
    
    
    //MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pull to refresh
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(fetchAllCoinPrices), for: .valueChanged)
        self.tableView.addSubview(refreshCtrl)
        
        // Parallax Header
        tableView.parallaxHeader.view = headerView // You can set the parallax header view from the floating view
        tableView.parallaxHeader.height = 150
        tableView.parallaxHeader.mode = MXParallaxHeaderMode.fill
        tableView.parallaxHeader.delegate = self
        
        //Fetch coin prices
        fetchAllCoinPrices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Define height of parallax header
        tableView.parallaxHeader.minimumHeight = topLayoutGuide.length
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    //MARK: - Helper Functions
    @objc func fetchAllCoinPrices() {
        
        //UIRefresh delay
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            self.refreshCtrl?.endRefreshing()
        })
        
        //Clear renderable coins
        renderableCoinsArray.removeAll()
        
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
                
                switch value.id {
                    case "bitcoin":
                        renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: value.symbol, coinIcon: UIImage(named: "bitcoin-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
                    case "ethereum":
                        renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: value.symbol, coinIcon: UIImage(named: "ethereum-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
                    case "ripple":
                        renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: value.symbol, coinIcon: UIImage(named: "ripple-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
                    case "bitcoin-cash":
                        renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: value.symbol, coinIcon: UIImage(named: "bitcoin-cash-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
                    case "litecoin":
                        renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: value.symbol, coinIcon: UIImage(named: "litecoin-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
                    case "raiblocks":
                        renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: value.symbol, coinIcon: UIImage(named: "raiblocks-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
                    case "monero":
                        renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: value.symbol, coinIcon: UIImage(named: "monero-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
                    case "stellar":
                        renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: value.symbol, coinIcon: UIImage(named: "stellar-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
                    case "iota":
                        renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: "IOT", coinIcon: UIImage(named: "iota-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
                    case "neo":
                        renderableCoinsArray.append(RenderableCoin(coinName: value.name, coinPrice: value.priceUSD, coinTicker: value.symbol, coinIcon: UIImage(named: "neo-icon"), priceChange: value.priceChange, tradeVolume: value.volume, marketCap: value.marketCap))
                    default:
                        break
                }
            }
            
            self.determinePriceChange()
            self.tableView.reloadData()
        }
        
    }
    
    func determinePriceChange() {
        var totalPriceChange = 0.0
        for i in 0..<renderableCoinsArray.count {
            if let priceChangePercentage = Double(renderableCoinsArray[i].priceChange) {
                if let totalPrice = Double(renderableCoinsArray[i].coinPrice) {
                    totalPriceChange = (priceChangePercentage * 0.01) * totalPrice
                    renderableCoinsArray[i].priceChange = "$\(String(totalPriceChange).setMinTailingDigits()) (\(priceChangePercentage)%)"
                }
            }
        }
    }
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    func formatMarketCap(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber)
        return result!
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
        
        //Check if coin data is out of bounds
        if renderableCoinsArray.count == 10 {
            
            //Coin name
            cell.coinName.text = renderableCoinsArray[indexPath.row].coinName
            
            //Coin price
            cell.coinPrice.text = formatCurrency(value: Double(renderableCoinsArray[indexPath.row].coinPrice)!)
            
            //Coin icon
            cell.coinIcon.contentMode = .scaleAspectFit
            cell.coinIcon.image = renderableCoinsArray[indexPath.row].coinIcon
            
            //Coin ticker/symbol
            cell.coinTicker.text = renderableCoinsArray[indexPath.row].coinTicker
            
            //Price change
            if renderableCoinsArray[indexPath.row].priceChange.contains("-") {
                cell.priceChange.textColor = .red
            } else {
                cell.priceChange.textColor = UIColor(red: 0/255, green: 143/255, blue: 0/255, alpha: 1.0)
            }
            cell.priceChange.text = renderableCoinsArray[indexPath.row].priceChange
            
            //Trade volume
            cell.tradeVolume.text = "24hr Trade Volume - \(formatMarketCap(value: Double(renderableCoinsArray[indexPath.row].tradeVolume)!))"
            
            //Market cap
            cell.marketCap.text = "Total Market Cap - \(formatMarketCap(value: Double(renderableCoinsArray[indexPath.row].marketCap)!))"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        DataManager.getHistoricalPrice(renderableCoinsArray[indexPath.row].coinTicker) { (JSON) in

            //Append selected coin data
            self.selectedCoinData.id = self.renderableCoinsArray[indexPath.row].coinName.lowercased()
            self.selectedCoinData.name = self.renderableCoinsArray[indexPath.row].coinName
            self.selectedCoinData.symbol = self.renderableCoinsArray[indexPath.row].coinTicker
            self.selectedCoinData.priceUSD = self.renderableCoinsArray[indexPath.row].coinPrice
            self.selectedCoinData.volume = self.renderableCoinsArray[indexPath.row].tradeVolume
            self.selectedCoinData.marketCap = self.renderableCoinsArray[indexPath.row].marketCap
            self.selectedCoinData.priceChange = self.renderableCoinsArray[indexPath.row].priceChange
            
            //Append selected coin history
            self.selectedCoinPriceHistory = PriceModel().parseHistoricalData(json: JSON, ticker: self.renderableCoinsArray[indexPath.row].coinTicker.uppercased(), name: self.renderableCoinsArray[indexPath.row].coinName)
            
            //Perform segue
            self.performSegue(withIdentifier: "priceToTrade", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "priceToTrade" {
            let destinationVC = segue.destination as! TradeViewController
            destinationVC.coinHistory = selectedCoinPriceHistory
            destinationVC.coinData = selectedCoinData
        }
    }
}


//MARK: - UITableViewCell
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


//MARK: - App Extensions
extension String {
    func setMinTailingDigits() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        return formatter.string(from: Double(self)! as NSNumber)!
    }
}
