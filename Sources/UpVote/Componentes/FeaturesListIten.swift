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
    @State var alreadyVoted: Bool = true
    
    public var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            HStack {
                VStack(alignment: .leading) {
                    if alreadyVoted {
                        HStack {
                            Text(UpVoteConfig.shared.alreadyVoteLabel)
                                .font(.DesignSystem.normalBold)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 4)
                                .foregroundColor(UpVoteConfig.shared.white)
                        }
                        .background(UpVoteConfig.shared.primaryColor)
                        .cornerRadius(4)
                    }
                    Text(featureaName)
                        .font(.DesignSystem.normalBold)
                        .padding(.bottom, 2)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .foregroundColor(UpVoteConfig.shared.textColor)
                    if !alreadyVoted {
                        Text(featureaDescription)
                            .font(.DesignSystem.smalRegular)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .foregroundColor(UpVoteConfig.shared.textColor)
                    }
                }
                .padding(.leading, 24)
                .padding(.top, 24)
                .padding(.bottom, 24)
                Spacer()
                VStack {
                    Text("\(voteCount)")
                        .font(.DesignSystem.largeTitleBold)
                        .foregroundColor(UpVoteConfig.shared.textColor)
                    Text(UpVoteConfig.shared.votesLabel)
                        .font(.DesignSystem.smalRegular)
                        .foregroundColor(UpVoteConfig.shared.textColor)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(.white)
                .cornerRadius(8)
                .padding(.trailing, 16)
                .padding(.leading, 32)
                .padding(.vertical, 16)
            }
            .background(UpVoteConfig.shared.backgroundColor)
            .cornerRadius(16)
        }
    }
}

struct FeaturesListIten_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesListIten()
    }
}
