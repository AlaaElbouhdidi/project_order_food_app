//
//  CheckoutView.swift
//  OrderAndEat
//
//  Created by Yasin Eraslan on 05.07.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import FirebaseFirestore
import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var orderData = getCartData()
    @EnvironmentObject var user: SessionStore
    
    
    
static let paymentTypes = ["Bar","Kreditkarte","Paypal"]
    
    @State private var paymentType = 0
    
    var body: some View {
        Form {
          /*  Section{
                
            }*/
            Section {
                Picker("How do you want to pay?", selection: $paymentType ) {
                    ForEach(0 ..< Self.paymentTypes.count) {
                        Text(Self.paymentTypes[$0])
                    }
                }
            }
            
            //Hier totalen Preis anzeigen
            Section(header: Text("TOTAL:  $totalPrice")) {
                Button("Order Now"){
                    placeOrder(user: self.user)
                }
            }
        }
        .navigationBarTitle(Text("Payment"),displayMode: .inline)
    }
}

func placeOrder(user:SessionStore) {
    let db = Firestore.firestore()
    
    if((user.session) != nil){
        db.collection("orders").document().setData([
            "uid" : user.session!.uid,
            "orderid" : UUID.init().uuidString])
    }
    
    //errors behandeln
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}
