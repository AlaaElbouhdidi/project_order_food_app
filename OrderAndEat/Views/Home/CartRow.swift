//
//  CartRow.swift
//  OrderAndEat
//
//  Created by Yasin Eraslan on 23.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartRow: View {
    var item: cart
    
    var body: some View {
        
        HStack{
            AnimatedImage(url: URL(string:item.pic))
            .resizable()
                .frame(width: 55, height: 55)
            .cornerRadius(10)
            
            VStack(alignment: .leading){
                Text(item.name)
                Text("x\(item.quantity)")
            }
        }
    }
}

/*
struct CartRow_Previews: PreviewProvider {
    static var previews: some View {
        CartRow()
    }
}*/
