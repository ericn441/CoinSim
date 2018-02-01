//
//  TransactionsViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/18/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit
import RealmSwift

class TransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - UI Componets
    var refreshCtrl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    
    //MARK: Transaction Data
    var wallet: Wallet = Wallet(id: "", name: "", symbol: "", amount: 0.0, amountUSD: 0.0)
    var transactionHistory: [TransactionRecord] = []
    var isBuyMenu: Bool = true
    
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pull to refresh
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(refreshTransactions), for: .valueChanged)
        self.tableView.addSubview(refreshCtrl)
        
        navigationItem.title = wallet.name + " Wallet"
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        refreshTransactions()
    }
    
    
    //MARK: - IBActions
    @IBAction func tappedBuyButton(_ sender: Any) {
        if #available(iOS 10.0, *) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
        
        isBuyMenu = true
        self.performSegue(withIdentifier: "transactionsToExchange", sender: nil)
    }
    
    @IBAction func tappedSellButton(_ sender: Any) {
        if #available(iOS 10.0, *) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
        
        isBuyMenu = false
        self.performSegue(withIdentifier: "transactionsToExchange", sender: nil)
    }
    
    
    //MARK: - Helper Functions
    @objc func refreshTransactions() {
        
        //Query transaction for selected coin
        if wallet.name == "USD" {
            let transactionRecordQuery = realm.objects(TransactionRecord.self).sorted(byKeyPath: "date", ascending: false)
            
            //Append results into array
            var transactions: [TransactionRecord] = []
            for results in transactionRecordQuery {
                transactions.append(TransactionRecord(id: results.id, coinName: results.coinName, coinSymbol: results.coinSymbol, date: results.date, transactionType: results.transactionType, buyAmount: results.buyAmount, buyAmountUSD: results.buyAmountUSD, sellAmount: results.sellAmount, sellAmountUSD: results.sellAmountUSD))
            }
            
            //return transaction records
            transactionHistory = transactions
            
        } else {
            let transactionRecordQuery = realm.objects(TransactionRecord.self).filter("coinName = '\(wallet.name)'").sorted(byKeyPath: "date", ascending: false)
            
            //Append results into array
            var transactions: [TransactionRecord] = []
            for results in transactionRecordQuery {
                transactions.append(TransactionRecord(id: results.id, coinName: results.coinName, coinSymbol: results.coinSymbol, date: results.date, transactionType: results.transactionType, buyAmount: results.buyAmount, buyAmountUSD: results.buyAmountUSD, sellAmount: results.sellAmount, sellAmountUSD: results.sellAmountUSD))
            }
            
            //return transaction records
            transactionHistory = transactions
        }
        
        //UIRefresh delay
        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
            self.tableView.reloadData()
            self.refreshCtrl?.endRefreshing()
        })
    }

    
    //MARK: - UITableView Protocols
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            return transactionHistory.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "Transaction History"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 { //Price Header
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! TransactionsHeaderTableViewCell
            
            headerCell.priceLabel.text = String(wallet.amount) + " \(wallet.symbol)"
            headerCell.priceUSDLabel.text = Utils.formatCurrency(value: Double(wallet.amountUSD))
            
            return headerCell
            
        } else if indexPath.section == 1 { //Buy & Sell Actions
            let actionsCell = tableView.dequeueReusableCell(withIdentifier: "actionsCell", for: indexPath) as! TransactionsActionTableViewCell
            return actionsCell
            
        } else { //Transaction History
            let historyCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! TransactionsHistoryTableViewCell
            
            if transactionHistory[indexPath.row].transactionType == "buy" {
                historyCell.actionIcon.image = UIImage(named: "buy-icon")
                historyCell.transactionType.text = "Bought " + transactionHistory[indexPath.row].coinName
                historyCell.amountLabel.text = String(transactionHistory[indexPath.row].buyAmount).setMaxTailingDigitsToEight() + " \(transactionHistory[indexPath.row].coinSymbol)"
                //historyCell.amountUSDLabel.text = "$"+String(transactionHistory[indexPath.row].buyAmountUSD)
                historyCell.amountUSDLabel.text = Utils.formatCurrency(value: transactionHistory[indexPath.row].buyAmountUSD)
                historyCell.date.text = transactionHistory[indexPath.row].date
            } else {
                historyCell.actionIcon.image = UIImage(named: "sell-icon")
                historyCell.transactionType.text = "Sold " + transactionHistory[indexPath.row].coinName
                historyCell.amountLabel.text = String(transactionHistory[indexPath.row].sellAmount) + " \(transactionHistory[indexPath.row].coinSymbol)"
                //historyCell.amountUSDLabel.text = "$"+String(transactionHistory[indexPath.row].sellAmountUSD)
                historyCell.amountUSDLabel.text = Utils.formatCurrency(value: transactionHistory[indexPath.row].sellAmountUSD)
                historyCell.date.text = transactionHistory[indexPath.row].date
            }

            return historyCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else if indexPath.section == 1 {
            return 80
        } else {
            return 70
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transactionsToExchange" {
            let destinationVC = segue.destination as! ExchangeViewController
            destinationVC.wallet = wallet
            destinationVC.isBuyMenu = isBuyMenu
        }
    }

}

class TransactionsHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceUSDLabel: UILabel!
}
class TransactionsActionTableViewCell: UITableViewCell {
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sellButton: UIButton!
}
class TransactionsHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var actionIcon: UIImageView!
    @IBOutlet weak var transactionType: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountUSDLabel: UILabel!
}
