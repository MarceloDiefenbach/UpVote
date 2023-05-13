//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 04/05/23.
//

public struct Vote {
    let id: String
    let createdTime: String
    let appCode: String
    let userID: String
    let featureID: String
}

public struct Feature {
    let id: String
    let name: String
    let description: String
    let votes: [Vote]
    let appCode: String
    let iVoteThis: Bool
}
