//
//  Order.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 13.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation

struct Order {
    
    enum State: String {
        case waiting
        case ready
    }
    
    var date: Date
    var personsCount: Int
    var state: State
    var orderId: String
}
