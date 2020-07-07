//
//  CartController.swift
//  OrderAndEat
//
//  Created by ii on 16.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import Foundation
import FirebaseFirestore

class getCartData : ObservableObject{
    
    @Published var datas = [cart]()
    @Published var total : NSNumber = 0.0
    
    init(uid: String) {
        
        let db = Firestore.firestore()
        
        db.collection("cart").whereField("uid", isEqualTo: uid).addSnapshotListener { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                
                if i.type == .added{
                    let id = i.document.documentID
                    let name = i.document.get("item") as! String
                    let pic = i.document.get("pic") as! String
                    let uid = i.document.get("uid") as? String ?? ""
                    
                    let quantity = i.document.get("quantity") as! NSNumber
                    var price : NSNumber = i.document.get("price") as! NSNumber
                    price = NSNumber(value: price.floatValue * quantity.floatValue)
                    self.total = NSNumber(value: self.total.floatValue + price.floatValue)

                    self.datas.append(cart(id: id, name: name, price: price, quantity: quantity, pic: pic, uid: uid))
                }
                
                if i.type == .modified{
                    
                    let id = i.document.documentID
                    let quantity = i.document.get("quantity") as! NSNumber
                    var price : NSNumber = i.document.get("price") as! NSNumber
                    price = NSNumber(value: price.floatValue * quantity.floatValue)
                    
                    self.total = 0.0
                    
                    for j in 0..<self.datas.count{
                        
                        if self.datas[j].id == id{
                            
                            self.datas[j].quantity = quantity
                            self.datas[j].price = price
                            
                        }
                        self.total = NSNumber(value: self.total.floatValue + self.datas[j].price.floatValue)
                    }
                }
                if i.type == .removed{
                    
                    let quantity = i.document.get("quantity") as! NSNumber
                    let price : NSNumber = i.document.get("price") as! NSNumber
                    let toSubstract : NSNumber = NSNumber(value: quantity.floatValue * price.floatValue)
                    
                    self.total = NSNumber(value: self.total.floatValue - toSubstract.floatValue)
                        
                    
                }
            }
        }
    }
}
struct cart : Identifiable {
    
    var id : String
    var name : String
    var price : NSNumber
    var quantity : NSNumber
    var pic : String
    var uid : String
    
}
