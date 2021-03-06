//
//  DetailView.swift
//  OrderAndEat
//
//  Created by ii on 17.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseFirestore

struct DetailView: View {
    var data : Food
    
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var reviews = getReviewData()
    
    func getReviewsOfThisFood() -> [Review]  {
        return self.reviews.datas.filter{
            $0.foodid.id == data.id
        }
    }
    var body : some View{
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 15){
                
                AnimatedImage(url: URL(string: data.pic!)!)
                    .resizable()
                    .frame(height: UIScreen.main.bounds.height / 2 - 100)
                
                VStack(alignment: .leading, spacing: 25) {
                    
                    Text(data.name!).fontWeight(.heavy).font(.title)
                    
                    HStack(){
                        
                        Text(data.price!+" €")
                            .fontWeight(.heavy)
                            .font(.title)
                        Spacer()
                        
                        
                    }
                    
                    Text("Ingredients: ").fontWeight(.heavy).font(.body)
                    Text("Beef with mixed salad in pita bread \nSauces: garlic or yogurt").font(.body)
                    Text("Reviews: ").fontWeight(.heavy).font(.body)
                    
                    
                    ForEach(getReviewsOfThisFood()) {i in
                        
                        ReviewView(data: i)
                        
                    }
                    
                    NavigationLink(destination: AddReviewView(food: self.data)) {
                            Text("Add a Review")
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    
                    
                }.padding()
                
                Spacer()
            }
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(data: Food(id: "a", name: "Döner", price: "5", pic: "https://cdn.pixabay.com/photo/2016/10/19/18/25/doner-kebab-1753615_960_720.jpg"))
    }
}
