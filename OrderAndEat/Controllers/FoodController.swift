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
    @Published var data = [food]()
    
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
                self.data.append(food(id: id, name: name, price: price, pic: pic))
            }
            
        }
    }
}
struct food: Identifiable {
    
    var id: String
    var name: String
    var price: String
    var pic: String
}
