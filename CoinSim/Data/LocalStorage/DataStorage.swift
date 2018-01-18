//
//  DataStorage.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 1/14/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import Foundation
import RealmSwift

class Wallet: Object {
    @objc dynamic var id: String?
    @objc dynamic var name: String?
}
