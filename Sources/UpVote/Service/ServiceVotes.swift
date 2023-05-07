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

    func getFeatures( appCode: String, userID: String, completion: @escaping ([Feature]?, Error?) -> Void) {
        guard let url = URL(string: "\(base_url)/airtable?appCode=\(appCode)") else {
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
                    var features = records.compactMap { Feature(record: $0) }
                    features[0].userIdVotes.append("123")
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

    func setVote(features: [Feature]) {

        var request = URLRequest(url: URL(string: "\(base_url)/vote")!)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: generateJSON(from: features))

        let data = """
            {
                "records": [
                    {
                        "id": "reco0iteeYW9lcArq",
                        "createdTime": "2023-05-03T17:12:57.000Z",
                        "fields": {
                            "appCode": "1",
                            "featureName": "Feature 1",
                            "featureDescription": "qwe",
                            "userIdVotes": [
                                "Marcelo",
                                "Duda",
                                "Lucas"
                            ]
                        }
                    },
                    {
                        "id": "recx0Cmv1WXgZjbJV",
                        "createdTime": "2023-05-04T13:46:40.000Z",
                        "fields": {
                            "appCode": "1",
                            "featureName": "Feature 2",
                            "featureDescription": "qwe",
                            "userIdVotes": [
                                "Marcelo"
                            ]
                        }
                    }
                ],
                "offset": "itrzcorivrgDZgX7t/recx0Cmv1WXgZjbJV"
            }
            """
        
        request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: data)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print(data)
                return
            }
            
            print(data)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print("Resposta: \(json)")
            } catch {
                print("Erro ao analisar a resposta JSON: \(error.localizedDescription)")
                return
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

