//
//  ReferInviteBannerViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 2/24/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class ReferInviteBanner: UIViewController, MFMessageComposeViewControllerDelegate {
    
    var inviteText = UILabel()
    var inviteButton = UIButton()
    
    override func viewDidLoad() {
        
        //view
        self.view.frame = CGRect(x: 0, y: self.view.frame.height - 128, width: self.view.frame.width, height: 80)
        if UIDevice.isIphoneX {
            self.view.frame = CGRect(x: 0, y: 650, width: self.view.frame.width, height: 80)
        }
        
        //invite button
        self.inviteButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.inviteButton.setImage(UIImage(named: "invite-banner-background"), for: .normal)
        inviteButton.addTarget(self, action: #selector(tapInvite), for: .touchUpInside)
        view.addSubview(inviteButton)
        
        //invite text
        self.inviteText.textColor = .white
        self.inviteText.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        self.inviteText.numberOfLines = 0
        self.inviteText.textAlignment = .center
        self.inviteText.frame = CGRect(x: 0, y: 8, width: self.view.frame.width, height: 60)
        self.inviteText.text = "Share #coinsim on FB/IG/Twitter. \n Get a chance to win real Bitcoin. Tap here."
        view.addSubview(inviteText)
        
        
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func tapInvite() {
        let vc = UIActivityViewController(activityItems: ["Checkout CoinSim! Trade Cryptos. Risk Free."], applicationActivities: [])
        present(vc, animated: true)
    }
    
}
