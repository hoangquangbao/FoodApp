//
//  Cart.swift
//  FoodApp
//
//  Created by Quang Bao on 04/09/2021.
//

import SwiftUI

struct Cart: Identifiable {
    
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
}
