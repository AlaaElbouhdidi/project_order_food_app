//
//  ReviewView.swift
//  OrderAndEat
//
//  Created by ii on 17.06.20.
//  Copyright © 2020 OrderAndEat. All rights reserved.
//

import SwiftUI

struct ReviewView: View {
    var body: some View {
        VStack(spacing: 20){
            HStack(spacing: 40){
                Text("Edward")
                    .multilineTextAlignment(.center)
                StarRatingView(rating: .constant(4))
                    .scaledToFit()
                Spacer()
            }
            HStack(spacing: 40){
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text("The taste is really good and the delivery is very fast. i can highly recommend it")
            }
        }
        
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
