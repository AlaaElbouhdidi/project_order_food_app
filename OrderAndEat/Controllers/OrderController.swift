//
//  OrderController.swift
//  OrderAndEat
//
//  Created by ii on 07.07.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import Foundation
import FirebaseFirestore
class getMyOrders : ObservableObject{
    
    @Published var datas = [Order]()
    
    init(uid: String) {
        
        let db = Firestore.firestore()
        
        db.collection("orders").whereField("uid", isEqualTo: uid).addSnapshotListener { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                
                    let id = i.document.documentID
                    let status = i.document.get("status") as! String
                    let total = i.document.get("total") as! NSNumber
                    let pt = i.document.get("payment-type") as! String

                    self.datas.append(Order(id: id, uid: uid, total: total, status: status, paymentType: pt))
                    
            }
        }
    }
}

struct Order : Identifiable {
    
    var id : String?
    var uid : String?
    var total : NSNumber?
    var status : String?
    var paymentType : String?
    
}
