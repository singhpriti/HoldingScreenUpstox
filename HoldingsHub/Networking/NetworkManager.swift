//
//  NetworkManager.swift
//  HoldingsHub
//
//  Created by Preity Singh on 14/11/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    /// Fetches the user's holdings from the API.
    /// - Parameter completion: A closure with the result containing an array of holdings or an error.
    func fetchHoldings(completion: @escaping (Result<[Holding], Error>) -> Void) {
        guard let url = URL(string: URLs.baseAPIURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -2, userInfo: nil)))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(apiResponse.data.userHolding))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

