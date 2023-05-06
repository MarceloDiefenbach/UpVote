//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 02/05/23.
//

import SwiftUI

public struct FeaturesListIten: View {
    
    @State var featureaName: String = "Request new products directly"
    @State var featureaDescription: String = "Feature description"
    @State var voteCount: Int = 0
    
    public var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            HStack {
                VStack(alignment: .leading) {
                    Text(featureaName)
                        .font(.DesignSystem.normalSemiBold)
                        .padding(.bottom, 2)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    Text(featureaDescription)
                        .font(.DesignSystem.smalRegular)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                .padding(.leading, 24)
                .padding(.top, 24)
                .padding(.bottom, 24)
                Spacer()
                VStack {
                    Text("\(voteCount)")
                        .font(.DesignSystem.largeTitleBold)
                    Text("votes")
                        .font(.DesignSystem.smalRegular)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(.white)
                .cornerRadius(8)
                .padding(.trailing, 16)
                .padding(.leading, 32)
                .padding(.vertical, 16)
            }
            .background(.black.opacity(0.03))
            .cornerRadius(16)
        }
    }
}

struct FeaturesListIten_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesListIten()
    }
}
