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
    
    @ObservedObject var cartdata = getCartData()
    @State private var showRow = true
    
    
    var body : some View{
        
        VStack(alignment: .leading){
            
            Text(self.cartdata.datas.count != 0 ? "Items In The Cart" : "No Items In Cart").padding([.top,.leading])
            
            
            if self.cartdata.datas.count != 0{
                
                List{
                    
                    
                    ForEach(self.cartdata.datas){i in
                        
                        
                        /* if i.quantity == 0 {
                         let db = Firestore.firestore()
                         db.collection("cart").document(self.cartdata.datas[i.last!].id).delete { (err) in
                         
                         if err != nil{
                         print((err?.localizedDescription)!)
                         return
                         }
                         
                         self.cartdata.datas.remove(atOffsets: i)
                         }
                         
                         }*/
                        
                        
                        HStack(spacing: 15){
                            
                            CartRow(item: i)
                                .onTapGesture {
                                    UIApplication.shared.windows.last?.rootViewController?.present(textFieldAlertView(id: i.id), animated: true, completion: nil)}
                            
                        }
                        .onAppear {
                            if i.quantity == 0 {
                                let db = Firestore.firestore()
                                db.collection("cart").document(self.cartdata.datas[i.last!].id).delete { (err) in
                                    
                                    if err != nil{
                                        print((err?.localizedDescription)!)
                                        return
                                    }
                                    
                                    self.cartdata.datas.remove(atOffsets: i)
                                }
                                
                            }
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
            }
            if self.cartdata.datas.count != 0{
                Button(action: {print("test")})
                {Text("Checkout").frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.black)
                    .font(.system(size: 14, weight: .bold))
                    .background(Color.yellow)
                    .cornerRadius(5)}
            }
            
        }.frame(width: UIScreen.main.bounds.width - 110, height: UIScreen.main.bounds.height - 350)
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
