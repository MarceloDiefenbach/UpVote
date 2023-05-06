//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 04/05/23.
//

struct Feature {
    let id: String
    let name: String
    let description: String
    let notes: [String]
    let appCode: String
    
    init?(record: [String: Any]) {
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
