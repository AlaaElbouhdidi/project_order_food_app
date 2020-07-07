//
//  MyOrdersView.swift
//  OrderAndEat
//
//  Created by ii on 07.07.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI

struct MyOrdersView: View {
    
    @ObservedObject var orders : getMyOrders
    
    var body: some View {
        
        VStack(alignment: .center){
        
            Text(self.orders.datas.count != 0 ? "My Orders" : "No available Order")
                .padding([.top,.leading, .bottom])
                .font(.title)
        
        
            if self.orders.datas.count != 0{
                HStack( spacing: 25){
                    Text("Status")
                    .font(.headline)
                    Spacer()
                    Text("With")
                    .font(.headline)
                    Spacer()
                    Text("Total")
                    .font(.headline)
                }.padding()
            
                List{
                    
                    ForEach(self.orders.datas){i in
                        
                        HStack(spacing: 15){
                            
                            
                            Text("\(i.status ?? "")")
                            Text("\(i.paymentType ?? "")")
                            Spacer()
                            Text("\(i.total ?? 0) €")
                        }
                        
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 110, height: UIScreen.main.bounds.height - 350)
        .background(Color.white)
        .cornerRadius(25)
    }
}

struct MyOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        MyOrdersView(orders: getMyOrders(uid: ""))
    }
}
