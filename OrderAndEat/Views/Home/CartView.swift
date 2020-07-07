//
//  CartView.swift
//  OrderAndEat
//
//  Created by ii on 16.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore

struct CartView : View {
    
    @ObservedObject var cartdata : getCartData
    @State var paymentType = 0
    @State var home : Home
    
    static let paymentTypes = ["Cash", "Credit card", "Paypal"]
    
    func addOrder(total: NSNumber, pt: String ) {
        if(total != 0){
            
            let db = Firestore.firestore()
            db.collection("orders")
                .document()
                .setData(["uid": self.cartdata.datas[0].uid, "total": total, "payment-type": pt, "status": "PENDING"]) { (err) in
                    
                    if err != nil{
                        
                        print((err?.localizedDescription)!)
                        return
                    }
            }
        }
    }
    
    func deleteAllCartItems(){
        let db = Firestore.firestore()
        for i in  self.cartdata.datas{
            db.collection("cart").document(i.id).delete { (err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
            }
        }
            
    }
    
    var body : some View{
            VStack(alignment: .center){
            
                Text(self.cartdata.datas.count != 0 ? "Items In The Cart" : "No Items In Cart")
                    .padding([.top,.leading])
                    .font(.title)
            
            
                if self.cartdata.datas.count != 0{
                
                List{
                    
                    ForEach(self.cartdata.datas){i in
                        
                        HStack(spacing: 15){
                            
                            AnimatedImage(url: URL(string: i.pic))
                                .resizable()
                                .frame(width: 55, height: 55)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading){
                                
                                Text(i.name)
                                Text("x\(i.quantity)")
                            }
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(i.price) €")
                            }
                        }
                        .onTapGesture {
                            
                            UIApplication.shared.windows.last?.rootViewController?.present(textFieldAlertView(id: i.id), animated: true, completion: nil)
                        }
                        
                    }
                    .onDelete { (index) in
                        
                        let db = Firestore.firestore()
                        db.collection("cart").document(self.cartdata.datas[index.last!].id).delete { (err) in
                            
                            if err != nil{
                                
                                print((err?.localizedDescription)!)
                                return
                            }
                            
                            self.cartdata.datas.remove(atOffsets: index)
                        }
                    }
                    
                }
                VStack{

                    Text("Total: \(self.cartdata.total) €")
                        .fontWeight(.bold)
                            .multilineTextAlignment(.trailing)
                        Spacer()
                        Text("How would you like to pay:")
                            .font(.headline)
                        
                        Picker("", selection: self.$paymentType ){
                            ForEach(0 ..< Self.paymentTypes.count) {
                                Text(Self.paymentTypes[$0])
                            }
                        }.labelsHidden()
                            .frame(maxWidth: 100, maxHeight: 100)
                }.padding(.bottom)
                    
                    if self.cartdata.datas.count != 0{
                        Button(action: {
                            self.addOrder(total: self.cartdata.total, pt: Self.paymentTypes[self.paymentType])
                            self.deleteAllCartItems()
                            self.home.show = false
                        }){
                            Text("Checkout").frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .bold))
                            .background(Color.yellow)
                            .cornerRadius(5)
                        }.padding(.top)
                    }
                }
            
        }
            .frame(width: UIScreen.main.bounds.width - 110, height: UIScreen.main.bounds.height - 350)
            .background(Color.white)
            .cornerRadius(25)
    }
}

func textFieldAlertView(id: String)->UIAlertController{
    
    let alert = UIAlertController(title: "Update", message: "Enter The Quantity", preferredStyle: .alert)
    
    alert.addTextField { (txt) in
        
        txt.placeholder = "Quantity"
        txt.keyboardType = .numberPad
    }
    
    let update = UIAlertAction(title: "Update", style: .default) { (_) in
        
        let db = Firestore.firestore()
        
        let value = alert.textFields![0].text!
            
        db.collection("cart").document(id).updateData(["quantity":Int(value)!]) { (err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
        }
    }
    
    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    
    alert.addAction(cancel)
    
    alert.addAction(update)
    
    return alert
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cartdata: getCartData(uid: ""), home: Home())
    }
}
