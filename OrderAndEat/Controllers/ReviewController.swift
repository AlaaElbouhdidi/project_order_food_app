//
//  ReviewController.swift
//  OrderAndEat
//
//  Created by ii on 22.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import Foundation
import FirebaseFirestore

class getReviewData : ObservableObject{
    
    @Published var datas = [Review]()
    
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("review").addSnapshotListener { (snap, err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
        
        for i in snap!.documentChanges{
            
            if i.type == .added{
                
                let id = i.document.documentID
                let userpic = i.document.get("userpic") as! String
                let username = i.document.get("username") as! String
                let stars = i.document.get("stars") as! NSNumber
                let reviewText = i.document.get("reviewtext") as! String
                let foodId = i.document.get("foodid") as! String
                
                self.datas.append(Review(id: id, stars: stars, reviewtext: reviewText, userpic: userpic, username: username,
                                         foodid: Food(id: foodId)))
            }
        }
        }
        
    }
}

struct Review : Identifiable {
    
    var id : String
    var stars : NSNumber
    var reviewtext : String
    var userpic : String
    var username : String
    var foodid : Food
}
