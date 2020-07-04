//
//  ReviewView.swift
//  OrderAndEat
//
//  Created by ii on 17.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ReviewView: View {
    
    var data : Review
    func getStars() -> Int {
        return  Int(self.data.stars) - 1
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack(spacing: 40){
                Text(data.username )
                    .multilineTextAlignment(.center)
                
                Spacer()
                StarRatingView(rating: .constant(getStars()))
                    .padding(.horizontal)
                    .scaledToFit()
            }
            HStack(spacing: 40){
                AnimatedImage(url: URL(string: data.userpic ))
                    .resizable()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    .shadow(radius: 10)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                Text(data.reviewtext)
                Spacer()
            }
        }
        
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(data: Review(id: "", stars: 4, reviewtext: "The taste is really good and the delivery is very fast. i can highly recommend it", userpic: " https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png" , username: " Ana", foodid: Food(id: "d")))
    }
}
