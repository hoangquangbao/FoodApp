//
//  ContentView.swift
//  FoodApp
//
//  Created by Quang Bao on 22/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            
            Home()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
