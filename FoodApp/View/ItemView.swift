//
//  ItemView.swift
//  FoodApp
//
//  Created by Quang Bao on 25/08/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    
    var item: Item
    var body: some View {
        
        VStack{
            
            //Downloading Image From Web....
            
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)
                .cornerRadius(15)
            
            
                //.frame(width: UIScreen.main.bounds.width - 30, height: 250)
                //.clipShape(Circle())
                //.frame(height: 250)
                //.frame(width: .infinity, height: 250, alignment: .center)
                //.frame(maxwidth: infini, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                //.frame(width: 250)
            
            //Spacer(minLength: 0)
            
            HStack(spacing: 8){
                
                Text(item.item_name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                //Ratings View....
                
                ForEach(1...5,id: \.self){index in
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_raitings) ?? 0 ? .pink : .gray)
                }
            }
            //
            .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
            
            HStack{
                
                Text(item.item_details)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }
            //
            .padding(EdgeInsets(top: 0, leading: 3, bottom: 0, trailing: 3))
        }
    }
}

