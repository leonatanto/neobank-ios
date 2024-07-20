//
//  WealthRepository.swift
//  neobank
//
//  Created by Leon Natanto on 16/07/24.
//

import Foundation

class WealthRepository {
    
    enum APIError: Error {
        case invalidURL
        case requestFailed
        case invalidResponse
        case decodingError
    }
    
    struct Product: Codable {
        let rate: Int
        let code: String
        let marketingPoints: [String]
        let productName: String
        let startingAmount: Int
        let isPopular: Bool
    }
    
    struct ProductGroup: Codable {
        let productList: [Product]
        let productGroupName: String
    }
    
    struct WealthData: Codable {
        let data: [ProductGroup]
    }
    
    func fetchData(completion: @escaping (Result<WealthData, Error>) -> Void) {
        guard let url = URL(string: "https://60c18a34-89cf-4554-b241-cd3cdfcc93ff.mock.pstmn.io/interview/deposits/list") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(APIError.requestFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(WealthData.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }.resume()
    }
}
