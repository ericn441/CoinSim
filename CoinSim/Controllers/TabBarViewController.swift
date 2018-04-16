//
//  TabBarViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 4/16/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit
import RealmSwift


class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check Onboarding
        if !UserDefaults.standard.bool(forKey: "didDoFirstAppOpen") {
            try! realm.write {
                realm.create(Wallet.self, value: ["id": "usd", "amountUSD":10000.0], update: true)
                UserDefaults.standard.set(true, forKey: "didDoFirstAppOpen")
                self.selectedIndex = 1
                //Mixpanel.mainInstance().identify(distinctId: UUID().uuidString)
            }
        } else {
            self.selectedIndex = 0
            AnalyticsManager.sendEvent(event: "Total Wallet Value", properties: ["Total USD Amount":Utils.formatCurrency(value: Utils.calculateTotalWalletValue())])
            
        }

    }

}
