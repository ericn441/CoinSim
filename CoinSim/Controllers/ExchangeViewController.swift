//
//  ExchangeViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/18/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit
import RealmSwift

class ExchangeViewController: UIViewController, MyTextFieldDelegate {
    
    @IBOutlet weak var usdBalance: UILabel!
    @IBOutlet weak var coinBalance: UILabel!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var coinSymbol: UILabel!
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var usdTextField: MyTextField!
    @IBOutlet weak var coinTextField: MyTextField!
    @IBOutlet weak var actionButton: UIButton!
    
    var wallet: Wallet = Wallet(id: "", name: "", symbol: "", amount: 0.0, amountUSD: 0.0)
    var usdWallet: Wallet = Wallet(id: "", name: "", symbol: "", amount: 0.0, amountUSD: 0.0)
    let realm = try! Realm()
    var isBuyMenu: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set textview delgates
        usdTextField.myDelegate = self
        coinTextField.myDelegate = self
        usdTextField.addTarget(self, action: #selector(typingUSDPrice), for: .allEditingEvents)
        coinTextField.addTarget(self, action: #selector(typingCoinPrice), for: .editingChanged)
        
        //Bring up number keyboard
        if isBuyMenu {
            usdTextField.becomeFirstResponder()
        } else {
            coinTextField.becomeFirstResponder()
        }
        
        //Set title
        if isBuyMenu {
            navigationItem.title = "Buy " + wallet.name
        } else {
            navigationItem.title = "Sell " + wallet.name
        }
        
        //Set coin symbol
        coinSymbol.text = wallet.symbol
        
        //Set coin icon
        coinIcon.contentMode = .scaleAspectFit
        coinIcon.image = UIImage(named: "\(wallet.id)-icon")
        
        //Set usd balance
        usdWallet = Wallet.defaultUSDWallet(in: realm)
        usdBalance.text = "USD Balance: \(formatCurrency(value: usdWallet.amountUSD))"
        
        //Set wallet balance
        coinBalance.text = "\(wallet.name) Balance: \(wallet.amount)"
        
        //Set coin price
        if let price = SharedCoinData.shared.dict[wallet.id]?.priceUSD {
            if let priceAsDouble = Double(price) {
                coinPrice.text = "Price of \(wallet.name): \(formatCurrency(value: priceAsDouble))"
            }
        }
        
        //Set action button
        if isBuyMenu {
            actionButton.setImage(UIImage(named: "large-buy-button"), for: .normal)
        } else {
            actionButton.setImage(UIImage(named: "large-sell-button"), for: .normal)
        }
    }
    
    
    //MARK: - TextField Protocols
    func textFieldDidDelete() {
        if usdTextField.text?.count == 1 {
            usdTextField.text?.removeAll()
        }
    }
    
    @objc func typingUSDPrice(textField: UITextField) {
        guard let inputValue = textField.text else { return }
        let editedInput = inputValue.replacingOccurrences(of: "$", with: "")
        guard let inputValueAsDouble = Double(editedInput) else { return }
        guard let coinPriceAsString = SharedCoinData.shared.dict[wallet.id]?.priceUSD else { return }
        guard let coinPrice = Double(coinPriceAsString) else { return }
        let calculatedCoinSum = inputValueAsDouble / coinPrice
        coinTextField.text = String(calculatedCoinSum).setMinTailingDigitsToEight()
        
        usdTextField.text = "$" + editedInput
        
        if usdTextField.text?.count == 1 {
            usdTextField.text?.removeAll()
        }
    }
    
    @objc func typingCoinPrice(textField: UITextField) {
        guard let inputValue = textField.text else { return }
        guard let inputValueAsDouble = Double(inputValue) else { return }
        guard let coinPriceAsString = SharedCoinData.shared.dict[wallet.id]?.priceUSD else { return }
        guard let coinPrice = Double(coinPriceAsString) else { return }
        let calculatedCoinSum = inputValueAsDouble * coinPrice
        usdTextField.text = formatCurrency(value: calculatedCoinSum)
    }
    
    
    //MARK: - Helper Functions
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber)
        return result!
    }

    
    
}



