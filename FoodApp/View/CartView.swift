//
//  CartView.swift
//  FoodApp
//
//  Created by Quang Bao on 04/09/2021.
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var homeDataCartView: HomeViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

