//
//  File.swift
//
//
//  Created by Marcelo Diefenbach on 03/05/23.
//

import Foundation

public class ServiceVotes {
    public static let shared = ServiceVotes()
    public var apiKey: String = ""

    private init() {}

    func getFeatures(appCode: String, completion: @escaping ([Feature]?, Error?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:5000/airtable?apiKey=1&appCode=\(appCode)") else {
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
                    let features = records.compactMap { Feature(record: $0) }
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


}
