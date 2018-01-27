//
//  TransactionsViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/18/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit

class TransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBActions
    @IBAction func tappedBuyButton(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        guard let superview = button.superview else { return }
        guard let cell = superview.superview as? TransactionsActionTableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        if #available(iOS 10.0, *) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
        
        self.performSegue(withIdentifier: "transactionsToExchange", sender: nil)
    }
    @IBAction func tappedSellButton(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        guard let superview = button.superview else { return }
        guard let cell = superview.superview as? TransactionsActionTableViewCell else { return }
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        if #available(iOS 10.0, *) {
            let impact = UIImpactFeedbackGenerator(style: .light)
            impact.impactOccurred()
        }
        
        self.performSegue(withIdentifier: "transactionsToExchange", sender: nil)
    }
    
    
    //MARK: - UITableView Protocols
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "Transaction History"
        } else {
            return ""
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! TransactionsHeaderTableViewCell

            return headerCell
        } else if indexPath.section == 1 {
            let actionsCell = tableView.dequeueReusableCell(withIdentifier: "actionsCell", for: indexPath) as! TransactionsActionTableViewCell

            return actionsCell
        } else {
            let historyCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! TransactionsHistoryTableViewCell

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
            //do work if needed
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
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var transactionType: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountUSDLabel: UILabel!
}
