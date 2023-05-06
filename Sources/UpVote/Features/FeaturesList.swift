//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 03/05/23.
//

import SwiftUI

public struct FeaturesList: View {
    
    @State var showingConfirmation = false
    @State var allFeatures: [Feature] = []
    @State var selectedFeature: Feature?
    @State var appCode: String
    
    public init(appCode: String) {
        self.appCode = appCode
        self.showingConfirmation = false
        self.allFeatures = []
    }
    
    public var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            NavigationView {
                ScrollView {
                    VStack {
                        ForEach(allFeatures, id: \.id) { feature in
                            FeaturesListIten(
                                featureaName: feature.name,
                                featureaDescription: feature.description,
                                voteCount: feature.notes.count
                            ).onTapGesture {
                                selectedFeature = feature
                                showingConfirmation = true
                                print(selectedFeature)
                            }
                            .sheet(isPresented: $showingConfirmation) {
                                if #available(iOS 16.0, *) {
                                    ConfirmModalSheet(title: feature.name, description: feature.description, onConfirm: {
                                        print(selectedFeature)
                                    }, isPresented: $showingConfirmation)
                                    .presentationDetents([.medium, .large])
                                } else {
                                    ConfirmModalSheet(title: feature.name, description: feature.description, onConfirm: {
                                        print(selectedFeature)
                                    }, isPresented: $showingConfirmation)
                                }

                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Features vote")
            }
        }.onAppear(){
            ServiceVotes.shared.getFeatures(appCode: self.appCode) { (value, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let features = value {
                    print("Features: \(features)")
                        allFeatures = features
                } else {
                    print("Unknown error occurred")
                }
            }
        }
    }
}

struct FeaturesList_Previews: PreviewProvider {
    static var previews: some View {
        FeaturesList(appCode: "1")
    }
}
