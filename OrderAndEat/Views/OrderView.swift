//
//  OrderView.swift
//  OrderAndEat
//
//  Created by ii on 16.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore

struct OrderView: View {
    var data : food
    @State var cash = false
    @State var quick = false
    @State var quantity = 0
    @Environment(\.presentationMode) var presentation
    
    var body : some View{
        
        VStack(alignment: .leading, spacing: 15){
            
            AnimatedImage(url: URL(string: data.pic)!)
                .resizable()
                .frame(height: UIScreen.main.bounds.height / 2 - 100)
            
            VStack(alignment: .leading, spacing: 25) {
                
                Text(data.name).fontWeight(.heavy).font(.title)
                Text(data.price+" €").fontWeight(.heavy).font(.body)
                
                Toggle(isOn : $cash){
                    
                    Text("Cash On Delivery")
                }
                
                Toggle(isOn : $quick){
                    
                    Text("Quick Delivery")
                }
                
                Stepper(onIncrement: {
                    
                    self.quantity += 1
                    
                }, onDecrement: {
                    
                    if self.quantity != 0{
                        
                        self.quantity -= 1
                    }
                }) {
                    
                    Text("Quantity \(self.quantity)")
                }
                
                Button(action: {
                    if(self.quantity != 0){
                        
                        let db = Firestore.firestore()
                        db.collection("cart")
                            .document()
                            .setData(["item":self.data.name,"quantity":self.quantity,"quickdelivery":self.quick,"cashondelivery":self.cash,"pic":self.data.pic]) { (err) in
                                
                                if err != nil{
                                    
                                    print((err?.localizedDescription)!)
                                    return
                                }
                            
                                // it will dismiss the recently presented modal....
                                
                                self.presentation.wrappedValue.dismiss()
                        }
                    }
                }) {
                    
                    Text("Add To Cart")
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                    
                }.background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                
            }.padding()
            
            Spacer()
        }
    }
}


