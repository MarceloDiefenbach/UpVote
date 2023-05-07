//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 04/05/23.
//

public struct Feature {
    public var id: String
    public var name: String
    public var description: String
    public var userIdVotes: [String]
    public var appCode: String
    
    public init?(record: [String: Any]) {
        guard let id = record["id"] as? String,
              let fields = record["fields"] as? [String: Any],
              let name = fields["featureName"] as? String,
              let description = fields["featureDescription"] as? String,
              let userIdVotes = fields["userIdVotes"] as? [String],
              let appCode = fields["appCode"] as? String else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.description = description
        self.userIdVotes = userIdVotes
        self.appCode = appCode
    }
}
