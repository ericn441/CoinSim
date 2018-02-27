//
//  AnalyticsManager.swift
//  CoinSim
//
//  Created by Eric Ngo - 1 on 2/16/18.
//  Copyright © 2018 Eric Ngo - 1. All rights reserved.
//

import Foundation
import Mixpanel
import Crashlytics
import Fabric

struct AnalyticsManager
{
    static func sendEvent(event: String, properties: [String:String]?) {
        Mixpanel.mainInstance().track(event: event, properties: properties)
        
        Answers.logCustomEvent(withName: event, customAttributes: properties)
    }
}

