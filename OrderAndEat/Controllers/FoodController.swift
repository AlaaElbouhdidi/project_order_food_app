//
//  FoodController.swift
//  OrderAndEat
//
//  Created by ii on 16.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import Foundation
import FirebaseFirestore

class getFoodData: ObservableObject {
    @Published var data = [Food]()
    
    init() {
        let db = Firestore.firestore()
        
        
        
        db.collection("food").addSnapshotListener { (snap, err) in
            if (err != nil){
                print((err?.localizedDescription)!)
                return
            }
            for i in snap!.documentChanges{
                let id = i.document.documentID
                let name = i.document.get("name") as! String
                let price = i.document.get("price") as! String
                let pic = i.document.get("pic") as! String
                self.data.append(Food(id: id, name: name, price: price, pic: pic))
            }
            
        }
    }
}
struct Food: Identifiable,Equatable,Codable {
    
    internal init(id: String, name: String? = nil, price: String? = nil, pic: String? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.pic = pic
    }
    
    
    var id: String
    var name: String?
    var price: String?
    var pic: String?
    
}
