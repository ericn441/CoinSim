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

    @IBOutlet weak var tableView: UITableView!
    var wallets: [Wallet] = []
    let realm = try! Realm()
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set navbar color
        navigationController?.navigationBar.barTintColor = UIColor(red: 23/255, green: 52/255, blue: 126/255, alpha: 1.0)
        
        //Load Wallets
        loadWallets()
        
        //TEST WRITES
        try! realm.write {
            realm.create(Wallet.self, value: ["id": "bitcoin", "amount":2.0], update: true)
            let wallet = realm.object(ofType: Wallet.self, forPrimaryKey: "bitcoin")!
            let priceData = Double(SharedCoinData.shared.dict["bitcoin"]!.priceUSD)
            realm.create(Wallet.self, value: ["id": "bitcoin", "amountUSD": priceData! * wallet.amount], update: true)
            self.tableView.reloadData()
        }
        
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
        
        //Wallet Amount
        cell.walletAmount.text = String(wallets[indexPath.row].amount) + " \(wallets[indexPath.row].symbol)"
        
        //Wallet Amount USD
        cell.walletAmountUSD.text = formatCurrency(value: wallets[indexPath.row].amountUSD)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.performSegue(withIdentifier: "walletToTransaction", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "walletToTransaction" {
            // do work
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
