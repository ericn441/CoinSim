//
//  WalletsViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/14/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit
import RealmSwift

class WalletsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - UI Componets
    @IBOutlet weak var tableView: UITableView!
    var refreshCtrl: UIRefreshControl!

    //MARK: - Wallet Data
    var wallets: [Wallet] = []
    let realm = try! Realm()
    var selectedIndex: Int = 0
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pull to refresh
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(refreshWalletValues), for: .valueChanged)
        self.tableView.addSubview(refreshCtrl)
        
        //Set navbar color
        navigationController?.navigationBar.barTintColor = UIColor(red: 23/255, green: 52/255, blue: 126/255, alpha: 1.0)
        
        //Load Wallets
        loadWallets()
        
        print(realm.configuration.fileURL)
    }
    
    
    //MARK: - Helper Functions
    func loadWallets() {
        
        //USD
        Wallet.defaultUSDWallet(in: realm)
        let usdWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "usd")
        wallets.append(usdWallet!)
        
        //Bitcoin
        Wallet.defaultBitcoinWallet(in: realm)
        let bitcoinWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "bitcoin")
        wallets.append(bitcoinWallet!)
        
        //Ethereum
        Wallet.defaultEthereumWallet(in: realm)
        let ethereumWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "ethereum")
        wallets.append(ethereumWallet!)
        
        //Ripple
        Wallet.defaultRippleWallet(in: realm)
        let rippleWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "ripple")
        wallets.append(rippleWallet!)
        
        //Bitcoin Cash
        Wallet.defaultBitcoinCashWallet(in: realm)
        let bitcoinCashWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "bitcoin-cash")
        wallets.append(bitcoinCashWallet!)
        
        //Litecoin
        Wallet.defaultLitecoinWallet(in: realm)
        let litecoinWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "litecoin")
        wallets.append(litecoinWallet!)
        
        //RaiBlocks
        Wallet.defaultRaiBlocksWallet(in: realm)
        let raiBlocksWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "raiblocks")
        wallets.append(raiBlocksWallet!)
        
        //Monero
        Wallet.defaultMoneroWallet(in: realm)
        let moneroWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "monero")
        wallets.append(moneroWallet!)
        
        //Stellar
        Wallet.defaultStellarWallet(in: realm)
        let stellarWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "stellar")
        wallets.append(stellarWallet!)
        
        //IOTA
        Wallet.defaultIOTAWallet(in: realm)
        let iotaWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "iota")
        wallets.append(iotaWallet!)
        
        //NEO
        Wallet.defaultNEOWallet(in: realm)
        let neoWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "neo")
        wallets.append(neoWallet!)
        
        self.tableView.reloadData()
    }
    func loadTransactionRecord(coinName: String) -> [TransactionRecord] {
        
        //Query transaction for selected coin
        let transactionRecordQuery = realm.objects(TransactionRecord.self).filter("coinName = '\(coinName)'")
        
        //Append results into array
        var transactionRecord: [TransactionRecord] = []
        for results in transactionRecordQuery {
            transactionRecord.append(TransactionRecord(id: results.id, coinName: results.coinName, coinSymbol: results.coinSymbol, date: results.date, transactionType: results.transactionType, buyAmount: results.buyAmount, buyAmountUSD: results.buyAmountUSD, sellAmount: results.sellAmount, sellAmountUSD: results.sellAmountUSD))
        }
        
        //return transaction records
        return transactionRecord

    }
    @objc func refreshWalletValues() {
        
        //***TEST WRITES***
//        try! realm.write {
//            realm.create(Wallet.self, value: ["id": "usd", "amountUSD":10000.0], update: true)
//            realm.create(Wallet.self, value: ["id": "bitcoin", "amount":2.0], update: true)
//            realm.create(Wallet.self, value: ["id": "ethereum", "amount":1.5], update: true)
//            realm.create(Wallet.self, value: ["id": "ripple", "amount":2021.0], update: true)
//            realm.create(Wallet.self, value: ["id": "litecoin", "amount":20.0], update: true)
//            realm.create(Wallet.self, value: ["id": "raiblocks", "amount":432.0], update: true)
//            self.tableView.reloadData()
//        }


        try! realm.write {

            //Update Bitcoin Wallet
            let bitcoinWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "bitcoin")!
            let bitcoinPriceData = Double(SharedCoinData.shared.dict["bitcoin"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "bitcoin", "amountUSD": bitcoinPriceData! * bitcoinWallet.amount], update: true)
            
            //Update Ethereum Wallet
            let ethereumWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "ethereum")!
            let ethereumPriceData = Double(SharedCoinData.shared.dict["ethereum"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "ethereum", "amountUSD": ethereumPriceData! * ethereumWallet.amount], update: true)
            
            //Update Ripple Wallet
            let rippleWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "ripple")!
            let ripplePriceData = Double(SharedCoinData.shared.dict["ripple"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "ripple", "amountUSD": ripplePriceData! * rippleWallet.amount], update: true)
            
            //Update Bitcoin Cash Wallet
            let bitcoinCashWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "bitcoin-cash")!
            let bitcoinCashPriceData = Double(SharedCoinData.shared.dict["bitcoin-cash"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "bitcoin-cash", "amountUSD": bitcoinCashPriceData! * bitcoinCashWallet.amount], update: true)
            
            //Update Litecoin Wallet
            let litecoinWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "litecoin")!
            let litecoinPriceData = Double(SharedCoinData.shared.dict["litecoin"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "litecoin", "amountUSD": litecoinPriceData! * litecoinWallet.amount], update: true)
            
            //Update Raiblocks Wallet
            let raiblocksWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "raiblocks")!
            let raiblocksPriceData = Double(SharedCoinData.shared.dict["raiblocks"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "raiblocks", "amountUSD": raiblocksPriceData! * raiblocksWallet.amount], update: true)
            
            //Update Monero Wallet
            let moneroWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "monero")!
            let moneroPriceData = Double(SharedCoinData.shared.dict["monero"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "monero", "amountUSD": moneroPriceData! * moneroWallet.amount], update: true)
            
            //Update Stellar Wallet
            let stellarWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "stellar")!
            let stellarPriceData = Double(SharedCoinData.shared.dict["stellar"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "stellar", "amountUSD": stellarPriceData! * stellarWallet.amount], update: true)
            
            //Update IOTA Wallet
            let iotaWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "iota")!
            let iotaPriceData = Double(SharedCoinData.shared.dict["iota"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "iota", "amountUSD": iotaPriceData! * iotaWallet.amount], update: true)
            
            //Update NEO Wallet
            let neoWallet = realm.object(ofType: Wallet.self, forPrimaryKey: "neo")!
            let neoPriceData = Double(SharedCoinData.shared.dict["neo"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "neo", "amountUSD": neoPriceData! * neoWallet.amount], update: true)
            
            //UIRefresh delay
            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
                self.tableView.reloadData()
                self.refreshCtrl?.endRefreshing()
            })

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
    
    
    //MARK: - UITableView Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath) as! WalletsTableViewCell
        
        //Wallet Name
        cell.walletName.text = wallets[indexPath.row].symbol + " Wallet"
        
        //Wallet Icon
        cell.coinIcon.contentMode = .scaleAspectFit
        cell.coinIcon.image = UIImage(named: "\(wallets[indexPath.row].id)-icon")
        
        //Wallet Amount USD
        cell.walletAmountUSD.text = formatCurrency(value: wallets[indexPath.row].amountUSD)
        
        //Wallet Amount
        if indexPath.row == 0 {
            cell.walletAmount.text?.removeAll()
        } else {
            cell.walletAmount.text = String(wallets[indexPath.row].amount) + " \(wallets[indexPath.row].symbol)"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "walletToTransaction", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "walletToTransaction" {
            let destinationVC = segue.destination as! TransactionsViewController
            destinationVC.wallet = wallets[selectedIndex]
            destinationVC.transactionHistory = loadTransactionRecord(coinName: wallets[selectedIndex].name)
        }
    }

}


//MARK: - UITableViewCell
class WalletsTableViewCell: UITableViewCell {
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var walletName: UILabel!
    @IBOutlet weak var walletAmountUSD: UILabel!
    @IBOutlet weak var walletAmount: UILabel!
}
