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
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Parallax Header
        tableView.parallaxHeader.view = headerView // You can set the parallax header view from the floating view
        tableView.parallaxHeader.height = 150
        tableView.parallaxHeader.mode = MXParallaxHeaderMode.fill
        tableView.parallaxHeader.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.parallaxHeader.minimumHeight = topLayoutGuide.length
    }
    
    //MARK: - UITableView Protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as! PricesTableViewCell
        //Round card corners
        cell.cardView.layer.cornerRadius = 5
        cell.cardView.layer.masksToBounds = true
        
        //disable cell highlight
        cell.selectionStyle = .none

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
    @IBOutlet weak var cardView: UIView!
    
}
