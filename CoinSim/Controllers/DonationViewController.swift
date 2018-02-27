//
//  DonationViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 2/27/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit

class DonationViewController: UIViewController {

    @IBOutlet weak var donateTitle: UILabel!
    @IBOutlet weak var donateSubTitle: UILabel!
    @IBOutlet weak var qrCode: UIImageView!
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var coinbaseButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var depositAddress: String = ""
    var donationType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Passed from segue
        address.text = depositAddress

        //QR code
        if donationType == "btc" {
            qrCode.image = UIImage(named: "bitcoin-address-qr")
            donateTitle.text = "Donate Bitcoin"
            addressTitle.text = "Bitcoin Address"
        } else if donationType == "eth" {
            qrCode.image = UIImage(named: "ethereum-address-qr")
            donateTitle.text = "Donate Ethereum"
            addressTitle.text = "Ethereum Addresss"
        }
        
        //Copy
        copyButton.backgroundColor = .clear
        copyButton.layer.cornerRadius = 5
        copyButton.layer.borderWidth = 1
        copyButton.layer.borderColor = UIColor.white.cgColor
        
        //Coinbase
        coinbaseButton.backgroundColor = .clear
        coinbaseButton.layer.cornerRadius = 5
        coinbaseButton.layer.borderWidth = 1
        coinbaseButton.layer.borderColor = UIColor.white.cgColor
        
        //Close
        closeButton.backgroundColor = .clear
        closeButton.layer.cornerRadius = 5
        closeButton.layer.borderWidth = 1
        closeButton.layer.borderColor = UIColor.white.cgColor
        
        //Share
        shareButton.backgroundColor = .clear
        shareButton.layer.cornerRadius = 5
        shareButton.layer.borderWidth = 1
        shareButton.layer.borderColor = UIColor.white.cgColor
    }
    @IBAction func didTapCopy(_ sender: UIButton) {
    }
    @IBAction func didTapDonate(_ sender: UIButton) {
    }
    @IBAction func didTapClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapShare(_ sender: UIButton) {
    }
    
}
