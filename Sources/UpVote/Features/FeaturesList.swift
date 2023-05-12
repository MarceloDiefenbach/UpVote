//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 03/05/23.
//

import SwiftUI

public struct FeaturesList: View {
    
    @StateObject var viewModel = FeaturesListViewModel()
    
    @State var appCode: String
    @State var userID: String
    
    public init(appCode: String, userID: String) {
        self.appCode = appCode
        self.userID = userID
    }
    
    public var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            NavigationView {
                ScrollView {
                    VStack {
                        ForEach(Array(viewModel.allFeatures.enumerated()), id: \.element.id) { index, feature in
                            FeaturesListIten(
                                featureaName: feature.name,
                                featureaDescription: feature.description,
                                voteCount: feature.userIdVotes.count,
                                alreadyVoted: feature.userIdVotes.contains(self.userID) == true ? true : false
                            )
                            .onTapGesture {
                                viewModel.selectedFeature = index
                                if !feature.userIdVotes.contains(self.userID) {
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Features to vote")
            }
            if viewModel.showingConfirmation {
                ConfirmModalSheet(
                    title: self.viewModel.allFeatures[viewModel.selectedFeature!].name,
                    description: self.viewModel.allFeatures[viewModel.selectedFeature!].description,
                    onConfirm: {
                        self.viewModel.allFeatures[viewModel.selectedFeature!].userIdVotes.append(self.userID)
                        ServiceVotes.shared.sendVoteToAPI(
                            featureID: self.viewModel.allFeatures[viewModel.selectedFeature!].id,
                            userIdVote: self.userID,
                            completion: { result, error in
                                if let result = result {
                                    print(result)
                                } else {
                                    print(error!)
                                }
                            }
                        )
                    },
                    isPresented: $viewModel.showingConfirmation)
            }
        }.onAppear(){
            viewModel.getFeatures(appCode: self.appCode, userID: self.userID)
        }
    }
}

struct FeaturesList_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesList(appCode: "1", userID: "Marcelo")
    }
}
