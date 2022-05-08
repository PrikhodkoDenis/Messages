//
//  FetchManager.swift
//  Messages
//
//  Created by Denis on 07.05.2022.
//

import UIKit

class FetchManager {
    
    static let shared = FetchManager()
    private let url = "https://numero-logy-app.org.in/getMessages?offset=0"
    
    func fetchData(completion: @escaping (_ result: Result<[String], FetchError>) -> ()) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.other))
            return
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if  let error = error {
                    let errorResult: FetchError = error.isNotConnected ? .isNotConnected : .other
                    completion(.failure(errorResult))
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let message = try decoder.decode(Message.self, from: data)
                        completion(.success(message.result.reversed()))
                    } catch {
                        completion(.failure(.parse))
                    }
                }
            }.resume()
        }
    }
}
