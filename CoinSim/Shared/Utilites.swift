//
//  Utilites.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/29/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class Utils
{
    static let sharedUtils = Utils()

    class func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    class func showErrorAlert(targetVC: UIViewController, errorMessage: String) {
        let alert = UIAlertController(title: errorMessage, message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        targetVC.present(alert, animated: true, completion: nil)
    }
}

//MARK: - App Extensions
extension String {
    func setMinTailingDigits() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        return formatter.string(from: Double(self)! as NSNumber)!
    }
    func setMaxTailingDigitsToEight() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 8
        return formatter.string(from: Double(self)! as NSNumber)!
    }
}

protocol MyTextFieldDelegate {
    func textFieldDidDelete()
}

class MyTextField: UITextField {
    
    var myDelegate: MyTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete()
    }
}
