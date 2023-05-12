//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 03/05/23.
//

import SwiftUI

public struct FeaturesList: View {
    
    @StateObject var viewModel = FeaturesListViewModel()
    
    @State var showingConfirmation: Bool = false
    
    public init() {
        
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
                                voteCount: feature.userIdVotes.count-1,
                                alreadyVoted: feature.userIdVotes.contains(ServiceVotes.shared.userID) == true ? true : false
                            )
                            .onTapGesture {
                                viewModel.selectedFeature = index
                                if !feature.userIdVotes.contains(ServiceVotes.shared.userID) {
                                    showingConfirmation = true
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle(UpVoteConfig.shared.listTitle)
            }
            if showingConfirmation {
                ConfirmModalSheet(
                    title: self.viewModel.allFeatures[viewModel.selectedFeature!].name,
                    description: self.viewModel.allFeatures[viewModel.selectedFeature!].description,
                    onConfirm: {
                        self.viewModel.allFeatures[viewModel.selectedFeature!].userIdVotes.append(ServiceVotes.shared.userID)
                        ServiceVotes.shared.sendVoteToAPI(
                            featureID: self.viewModel.allFeatures[viewModel.selectedFeature!].id,
                            userIdVote: ServiceVotes.shared.userID,
                            completion: { result, error in
                                if let result = result {
                                    viewModel.getFeatures()
                                } else {
                                    print(error!)
                                }
                            }
                        )
                    },
                    isPresented: $showingConfirmation)
            }
        }.onAppear(){
            ServiceVotes.shared.appCode = "reclOOpdQTZpAZZik"
            ServiceVotes.shared.userID = "Marcelo"
            viewModel.getFeatures()
        }
    }
}

struct FeaturesList_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesList()
    }
}
