//
//  File.swift
//
//
//  Created by Marcelo Diefenbach on 03/05/23.
//

import Foundation

public class ServiceVotes {
    
    private let base_url: String = "http://127.0.0.1:5000"
    
    public static let shared = ServiceVotes()

    private init() {}

    func getFeatures(appCode: String, userID: String, completion: @escaping ([Feature]?, Error?) -> Void) {
        guard let url = URL(string: "\(base_url)/getFeatures?appCode=\(appCode)") else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data returned", code: -1, userInfo: nil))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let records = json["records"] as? [[String: Any]] {
                    let features = records.compactMap { record -> Feature? in
                        guard let id = record["id"] as? String,
                              let fields = record["fields"] as? [String: Any],
                              let name = fields["featureName"] as? String,
                              let description = fields["featureDescription"] as? String,
                              let userIdVotes = fields["userIdVotes"] as? [String],
                              let appCode = fields["appCode"] as? String else {
                            return nil
                        }

                        return Feature(id: id, name: name, description: description, userIdVotes: userIdVotes, appCode: appCode)
                    }
                    completion(features, nil)
                } else {
                    completion(nil, NSError(domain: "Invalid JSON format", code: -1, userInfo: nil))
                }
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }


    func sendVoteToAPI(featureID: String, userIdVote: String, completion: @escaping ([Feature]?, Error?) -> Void) {
        let url = URL(string: "\(base_url)/vote")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params: [String: Any] = ["featureID": featureID, "userIdVote": userIdVote]
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error sending vote: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print("Response from server: \(responseJSON)")
            } else {
                print("Error parsing server response")
            }
        }
        task.resume()
    }
}

func generateJSON(from features: [Feature]) -> String? {
    let records = features.map { feature in
        return [
            "id": feature.id,
            "fields": [
                "appCode": feature.appCode,
                "Notes": feature.userIdVotes,
                "featureName": feature.name,
                "featureDescription": feature.description
            ]
        ]
    }
    
    let jsonDictionary = ["records": records]
    
    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: []),
          let jsonString = String(data: jsonData, encoding: .utf8) else {
        return nil
    }
    
    return jsonString
}

