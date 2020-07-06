//
//  Order.swift
//  iDine
//
//  Created by Paul Hudson on 27/06/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import SwiftUI

class Order : ObservableObject{
    @Published var items = [Food]()

    /*
    var total: Int {
        
        if items.count > 0 {
            
            return items.reduce(0) { $0 + $1.price) }
        } else {
            return 0
        }
    }
*/
    func add(item: Food) {
        items.append(item)
    }

    func remove(item: Food) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}
