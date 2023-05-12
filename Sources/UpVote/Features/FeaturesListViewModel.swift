//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 08/05/23.
//

import Foundation
import Combine
import SwiftUI

class FeaturesListViewModel: ObservableObject {
    internal let objectWillChange = ObservableObjectPublisher()

    func updateView(){
        objectWillChange.send()
    }
    
    @Published var showingConfirmation = false
    @Published var allFeatures: [Feature] = []
    @Published var selectedFeature: Int?
    
    func getFeatures() {
        ServiceVotes.shared.getFeatures() { (value, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let features = value {
                print("Features: \(features)")
                self.allFeatures = features
                self.updateView()
            } else {
                print("Unknown error occurred")
            }
        }
    }
}
