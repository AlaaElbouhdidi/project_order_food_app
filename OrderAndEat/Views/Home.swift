//
//  Home.swift
//  OrderAndEat
//
//  Created by ii on 16.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject var food = getFoodData()
    var body: some View {
        VStack{
            if self.food.data.count != 0{
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15){
                        ForEach(self.food.data) {i in
                            
                                CellView(data: i)
                            
                        }
                    }.padding()
                }
            }
            else {
                Loader()
            }
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
