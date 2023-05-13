//
//  File.swift
//
//
//  Created by Marcelo Diefenbach on 03/05/23.
//

import Foundation

public class ServiceVotes {
    
    public static let shared = ServiceVotes()
    
//    private let base_url: String = "https://gpt-treinador.herokuapp.com/"
    private let base_url: String = "http://127.0.0.1:5000/"
    var appCode: String = UpVoteConfig.shared.appCode
    var userID: String = UpVoteConfig.shared.userID

    private init() {}

    func getFeatures(completion: @escaping ([Feature]?, Error?) -> Void) {
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
                    print(records)
                    let features = records.compactMap { record -> Feature? in
                        guard let id = record["id"] as? String,
                              let fields = record["fields"] as? [String: Any],
                              let name = fields["featureName"] as? String,
                              let description = fields["featureDescription"] as? String,
                              let votesData = fields["votes"] as? [[String: Any]],  // Alterado para [[String: Any]]
                              let appCode = fields["appCode"] as? String else {
                            return nil
                        }
                        
                        var allVotes: [Vote] = []
                        
                        for voteData in votesData {
                            if let voteFields = voteData["fields"] as? [String: Any],
                               let voteID = voteData["id"] as? String,
                               let voteCreatedTime = voteData["createdTime"] as? String,
                               let userID = voteFields["userID"] as? String,
                               let featureID = voteFields["featureID"] as? String {
                                
                                let vote = Vote(id: voteID, createdTime: voteCreatedTime, appCode: appCode, userID: userID, featureID: featureID)
                                allVotes.append(vote)
                            }
                        }
                        let hasVoteWithUserIDABC = allVotes.contains { $0.userID == self.userID }
                        
                        return Feature(id: id, name: name, description: description, votes: allVotes, appCode: appCode, iVoteThis: hasVoteWithUserIDABC)
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


    func sendVoteToAPI(featureID: String, completion: @escaping ([Feature]?, Error?) -> Void) {
        let url = URL(string: "\(base_url)/vote")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "appCode": self.appCode,
            "userID": self.userID,
            "featureID": featureID
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Vote created successfully")
            } else {
                print("Failed to create vote. Status code: \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
    }
}

