//
//  Items.swift
//  FoodApp
//
//  Created by Quang Bao on 25/08/2021.
//

import SwiftUI

struct Item: Identifiable{
    
    var id: String
    var item_name: String
    var item_cost: NSNumber
    var item_details: String
    var item_image: String
    var item_raitings: String
    
    // To identify whether it is added to cart....
    var isAdded: Bool = false
}
