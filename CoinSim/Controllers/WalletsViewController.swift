//
//  WalletsViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/14/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit

class WalletsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set navbar color
        navigationController?.navigationBar.barTintColor = UIColor(red: 23/255, green: 52/255, blue: 126/255, alpha: 1.0)
    }
    
    
    //MARK: - UITableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "walletCell", for: indexPath) as! WalletsTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //do work if needed
    }

}


//MARK: - UITableViewCell
class WalletsTableViewCell: UITableViewCell {
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var walletName: UILabel!
    @IBOutlet weak var walletAmountUSD: UILabel!
    @IBOutlet weak var walletAmount: UILabel!
}
