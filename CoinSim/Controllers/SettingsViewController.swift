//
//  SettingsViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 2/8/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var nanoButton: UIButton!
    @IBOutlet weak var bitcoinButton: UIButton!
    @IBOutlet weak var ethereumButton: UIButton!
    @IBOutlet weak var openSourceButton: UIButton!
    
    let btcAddress = "1993Dn6LQyjiiSRQCWNgsod8oBXwgjXzQV"
    let ethAddress = "0xA6C8628B883184C83545D1219516F20781675d3f"
    var donationType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Nano
        nanoButton.backgroundColor = .clear
        nanoButton.layer.cornerRadius = 5
        nanoButton.layer.borderWidth = 1
        nanoButton.layer.borderColor = UIColor.white.cgColor
        
        let nanoString = NSMutableAttributedString(string: "")
        let nanoAttachment = NSTextAttachment()
        nanoAttachment.image = UIImage(named: "nano-icon")
        let nanoImageString = NSAttributedString(attachment: nanoAttachment)
        nanoString.append(nanoImageString)
        nanoString.append(NSMutableAttributedString(string: " Donate Nano",
                                                    attributes: [NSAttributedStringKey.font:  UIFont(name: "HelveticaNeue", size: 22)!]))
        nanoButton.setAttributedTitle(nanoString, for: .normal)
        
        //Bitcoin
        bitcoinButton.backgroundColor = .clear
        bitcoinButton.layer.cornerRadius = 5
        bitcoinButton.layer.borderWidth = 1
        bitcoinButton.layer.borderColor = UIColor.white.cgColor
        
        let bitcoinString = NSMutableAttributedString(string: "")
        let bitcoinAttachment = NSTextAttachment()
        bitcoinAttachment.image = UIImage(named: "bitcoin-icon")
        let bitcoinImageString = NSAttributedString(attachment: bitcoinAttachment)
        bitcoinString.append(bitcoinImageString)
        bitcoinString.append(NSMutableAttributedString(string: " Donate Bitcoin",
                                                    attributes: [NSAttributedStringKey.font:  UIFont(name: "HelveticaNeue", size: 22)!]))
        bitcoinButton.setAttributedTitle(bitcoinString, for: .normal)
        
        //Ethereum
        ethereumButton.backgroundColor = .clear
        ethereumButton.layer.cornerRadius = 5
        ethereumButton.layer.borderWidth = 1
        ethereumButton.layer.borderColor = UIColor.white.cgColor
        
        let ethereumString = NSMutableAttributedString(string: "")
        let ethereumAttachment = NSTextAttachment()
        ethereumAttachment.image = UIImage(named: "ethereum-icon")
        let ethereumImageString = NSAttributedString(attachment: ethereumAttachment)
        ethereumString.append(ethereumImageString)
        ethereumString.append(NSMutableAttributedString(string: " Donate Ethereum",
                                                    attributes: [NSAttributedStringKey.font:  UIFont(name: "HelveticaNeue", size: 22)!]))
        ethereumButton.setAttributedTitle(ethereumString, for: .normal)
        
        //Open Source
        openSourceButton.backgroundColor = .clear
        openSourceButton.layer.cornerRadius = 5
        openSourceButton.layer.borderWidth = 1
        openSourceButton.layer.borderColor = UIColor.white.cgColor
        
    }
    @IBAction func showNanoDonation(_ sender: UIButton) {
        //do work in future
    }
    @IBAction func showBitcoinDonation(_ sender: UIButton) {
        donationType = "btc"
        self.performSegue(withIdentifier: "donationScreen", sender: nil)
    }
    @IBAction func showEthereumDonation(_ sender: UIButton) {
        donationType = "eth"
        self.performSegue(withIdentifier: "donationScreen", sender: nil)
    }
    @IBAction func showOpenSource(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DonationViewController
        if donationType == "eth" {
            destinationVC.depositAddress = ethAddress
            destinationVC.donationType = "eth"
        } else if donationType == "btc" {
            destinationVC.depositAddress = btcAddress
            destinationVC.donationType = "btc"
        }
    }
}
