//
//  ExchangeViewController.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/18/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import UIKit
import RealmSwift
import NVActivityIndicatorView

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
    
    //MARK: - IBActions
    @IBAction func tappedActionButton(_ sender: UIButton) {
        if isBuyMenu { //MARK: Buy
            let buyAlert = UIAlertController(title: "Buy \(coinTextField.text!) \(wallet.name) for \(usdTextField.text!)?", message: "", preferredStyle: UIAlertControllerStyle.alert)
            buyAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            
            //Buy Action
            buyAlert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: { action in
               
                //Check if input values are valids
                guard let buyInput = self.coinTextField.text else { return }
                guard let buyAmount = Double(buyInput) else { return }
                guard let buyInputUSD = self.usdTextField.text else { return }
                let removedDollarSign = buyInputUSD.replacingOccurrences(of: "$", with: "")
                let removedComma = removedDollarSign.replacingOccurrences(of: ",", with: "")
                guard let buyAmountUSD = Double(removedComma) else { return }
                
                //Check if USD balance is available
                if self.usdWallet.amountUSD >= buyAmountUSD {
                    
                    //Log the transaction
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
                    let dateStr =  dateFormatter.string(from: Date())
                    
                    TransactionRecord.createBuyTransaction(in: self.realm, coinName: self.wallet.name, coinSymbol: self.wallet.symbol, date: dateStr, transactionType: "buy", buyAmount: buyAmount, buyAmountUSD: buyAmountUSD)
                    
                    //add coin to wallet
                    let newBuyTotal = self.wallet.amount + buyAmount
                    let newBuyUSDTotal = self.wallet.amountUSD + buyAmountUSD
                    
                    //Subtract $ from bank
                    let bankTotalUSD = self.usdWallet.amountUSD - buyAmountUSD

                    try! self.realm.write {
                        self.realm.create(Wallet.self, value: ["id": self.usdWallet.id, "amountUSD": bankTotalUSD], update: true)
                        self.realm.create(Wallet.self, value: ["id": self.wallet.id, "amount": newBuyTotal, "amountUSD": newBuyUSDTotal], update: true)
                    }
                    
                    //update UI and segue
                    self.showLoadingAlert(completionHandler: { (completed) in
                        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
                            self.dismiss(animated: true, completion: {
                                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
                            })
                        })
                    })
                    
                } else {
                    self.showErrorAlert(errorMessage: "You do not have enough $$$ to buy \(self.wallet.name) 😢")
                }
                
            }))
            
            self.present(buyAlert, animated: true, completion: nil)
            
        } else { //MARK: Sell
            let sellAlert = UIAlertController(title: "Sell \(coinTextField.text!) \(wallet.name) for \(usdTextField.text!)?", message: "", preferredStyle: UIAlertControllerStyle.alert)
            sellAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            
            //Sell Action
            sellAlert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler: { action in
                //Check if input values are valids
                guard let sellInput = self.coinTextField.text else { print("sell input failed"); return }
                guard let sellAmount = Double(sellInput) else { print("sell amount failed"); return }
                guard let sellInputUSD = self.usdTextField.text else { print("sell usd failed"); return }
                let removedDollarSign = sellInputUSD.replacingOccurrences(of: "$", with: "")
                let removedComma = removedDollarSign.replacingOccurrences(of: ",", with: "")
                print(removedComma)
                guard let sellAmountUSD = Double(removedComma) else { print("sell amountUSD failed"); return }
                
                //Check if USD balance is available
                if sellAmount <= self.wallet.amount {
                    
                    //Log the transaction
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
                    let dateStr =  dateFormatter.string(from: Date())
                    
                    TransactionRecord.createSellTransaction(in: self.realm, coinName: self.wallet.name, coinSymbol: self.wallet.symbol, date: dateStr, transactionType: "sell", sellAmount: sellAmount, sellAmountUSD: sellAmountUSD)
                    
                    //add $ to bank
                    let bankTotalUSD = self.usdWallet.amountUSD + sellAmountUSD
                    
                    //subtract coin from wallet
                    let newSellTotal = self.wallet.amount - sellAmount
                    let newSellUSDTotal = self.wallet.amountUSD - sellAmountUSD
                    
                    try! self.realm.write {
                        self.realm.create(Wallet.self, value: ["id": self.usdWallet.id, "amountUSD": bankTotalUSD], update: true)
                        self.realm.create(Wallet.self, value: ["id": self.wallet.id, "amount": newSellTotal, "amountUSD": newSellUSDTotal], update: true)
                    }
                    
                    //update UI and segue
                    self.showLoadingAlert(completionHandler: { (completed) in
                        let triggerTime = (Int64(NSEC_PER_SEC) * 1)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(triggerTime) / Double(NSEC_PER_SEC), execute: { () -> Void in
                            self.dismiss(animated: true, completion: {
                                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
                            })
                        })
                    })
                    
                } else {
                    self.showErrorAlert(errorMessage: "You do not have enough \(self.wallet.name) to sell for $$$ 😢")
                }
            }))
            
            self.present(sellAlert, animated: true, completion: nil)
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
        coinTextField.text = String(calculatedCoinSum).setMaxTailingDigitsToEight()
        
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
    func showLoadingAlert(completionHandler: @escaping (_ isCompleted: Bool) -> Void) {
        let alertController = UIAlertController(title: "Processing...\n\n", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 135.0, y: 65.5, width: 75, height: 75), type: .ballTrianglePath, color: .blue, padding: 20)
        activityIndicator.center = CGPoint(x: 135.0, y: 70.5)
        alertController.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        present(alertController, animated: true, completion: {
            completionHandler(true)
        })
    }
    func showErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: errorMessage, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}



