//
//  TradeViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/11/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit
import ScrollableGraphView

class TradeViewController: UIViewController, ScrollableGraphViewDataSource {

    //MARK: - UI Componets
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var coinPrice: UILabel!
    @IBOutlet var coinPriceChange: UILabel!
    @IBOutlet var buyButton: UIButton!
    @IBOutlet var sellbutton: UIButton!
    @IBOutlet var walletText: UIButton!
    @IBOutlet var walletAmountUSD: UIButton!
    @IBOutlet var walletAmount: UIButton!
    @IBOutlet var coinIcon: UIImageView!
    
    
    //MARK: - Coin Data
    var coinHistory: [CoinHistory] = []
    var coinData: CoinObject = CoinObject(id: "", name: "", symbol: "", priceUSD: "", volume: "", marketCap: "", priceChange: "")
    var maxCoinPrice: Double = 0.0
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set title
        navigationItem.title = "\(coinData.name) Price"
        navigationController?.navigationBar.barTintColor = UIColor(red: 23/255, green: 52/255, blue: 126/255, alpha: 1.0)
        
        //Set price
        coinPrice.text = formatCurrency(value: Double(coinData.priceUSD)!)
        
        //Set price change
        if coinData.priceChange.contains("-") {
             coinPriceChange.textColor = .red
        } else {
             coinPriceChange.textColor = UIColor(red: 0/255, green: 143/255, blue: 0/255, alpha: 1.0)
        }
        coinPriceChange.text = coinData.priceChange + " this day"
        
        //Convert time
        convertUnixTimeToLocal()
        
        //Load graph
        plotGraph()
        
        //Set wallet icon
        coinIcon.contentMode = .scaleAspectFit
        coinIcon.image = UIImage(named:"\(coinData.id)-icon")
        
        //Set wallet name
        walletText.setTitle(coinData.name + " Wallet", for: .normal)
        
        //Set wallet amount
        walletAmount.setTitle("2.43539084 \(coinData.symbol.uppercased())", for: .normal)
        
        //Set wallet amount USD
        walletAmountUSD.setTitle("$100,000.00", for: .normal)
        
        
        
    }
    
    
    //MARK: - Helper Functions
    func plotGraph() {
        var prices: [Double] = []
        
        for results in coinHistory {
            prices.append(Double(results.closePrice))
        }
        
        let graphView = ScrollableGraphView(frame: CGRect(x: 16, y: 110, width: 343, height: 332), dataSource: self)
        let linePlot = LinePlot(identifier: "line") // Identifier should be unique for each plot if needed.
        let referenceLines = ReferenceLines() //Line settings
        
        if prices.max()! < 1.0 { //Scale coins under a dollar up by 10x
            for i in 0..<prices.count {
                prices[i] = prices[i] * 100
            }
            graphView.rangeMax = prices.max()!
            graphView.rangeMin = prices.min()!
            maxCoinPrice = graphView.rangeMax / 100
        } else {
            graphView.rangeMax = prices.max()!
            graphView.rangeMin = prices.min()!
            maxCoinPrice = graphView.rangeMax
        }
        
        graphView.addPlot(plot: linePlot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        self.scrollView.addSubview(graphView)
    }
    
    func convertUnixTimeToLocal() {
        for results in coinHistory {
            let date = NSDate(timeIntervalSince1970: TimeInterval(results.time))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.timeZone = TimeZone.current
            let localDate = dateFormatter.string(from: date as Date)
            if let index = (localDate.range(of: ",")?.lowerBound) {
                let beforeEqualsTo = String(localDate.prefix(upTo: index))
                results.readableTime = beforeEqualsTo
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
    
    
    //MARK: - GraphView Delegates
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        if maxCoinPrice < 1.0 { //Scale graph if coin price is < $1.00
            return Double(coinHistory[pointIndex].closePrice) * 100
        } else {
            return Double(coinHistory[pointIndex].closePrice)
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return coinHistory[pointIndex].readableTime
    }
    
    func numberOfPoints() -> Int {
        return coinHistory.count
    }

}
