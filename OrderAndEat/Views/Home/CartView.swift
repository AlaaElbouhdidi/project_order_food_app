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
    var uid: String
    
    func getCartDataOfThisUser() -> [cart]  {
        return self.cartdata.datas.filter{
            $0.uid == self.uid
        }
    }
    
    var body : some View{
        
        VStack(alignment: .leading){
            
            Text(self.getCartDataOfThisUser().count != 0 ? "Items In The Cart" : "No Items In Cart").padding([.top,.leading])
            
            
            if self.getCartDataOfThisUser().count != 0{
                
                List{
                    
                    ForEach(self.getCartDataOfThisUser()){i in
                        
                        HStack(spacing: 15){
                            
                            AnimatedImage(url: URL(string: i.pic))
                                .resizable()
                                .frame(width: 55, height: 55)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading){
                                
                                Text(i.name)
                                Text("x\(i.quantity)")
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
            }
            
            if self.cartdata.datas.count > 0{
                
                //Button um zur CheckoutView zu gelangen
                NavigationView {
                    VStack {
                    NavigationLink(destination: CheckoutView()){
                            Text("Checkout")
                        }
                    }
                }
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

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(uid: "")
    }
}
