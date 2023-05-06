//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 04/05/23.
//

public struct Feature {
    public let id: String
    public let name: String
    public let description: String
    public let notes: [String]
    public let appCode: String
    
    public init?(record: [String: Any]) {
        guard let id = record["id"] as? String,
              let fields = record["fields"] as? [String: Any],
              let name = fields["featureName"] as? String,
              let description = fields["featureDescription"] as? String,
              let notes = fields["Notes"] as? [String],
              let appCode = fields["appCode"] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.description = description
        self.notes = notes
        self.appCode = appCode
    }
}
