//
//  Firebase.swift
//  SenaFlix
//
//  Created by Lucas Sena on 19/06/24.
//

import Foundation

struct CoreResponse {
    var data: Data?
    var error: Error?
}

struct CoreRequest {
    let url: String
    let api_key: String
    
    func fetchData(completion: @escaping (CoreResponse) -> Void) {
        var coreResponse = CoreResponse()
        let urlString = "\(url)\(api_key)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if (error != nil) {
                    coreResponse.error = error
                    completion(coreResponse)
                    return
                }
                if let safeData = data {
                    coreResponse.data = safeData
                    completion(coreResponse)
                    return
                }
            }
            task.resume()
        }
    }
}
