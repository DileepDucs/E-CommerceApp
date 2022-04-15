//
//  APIClient.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation

class APIClient: APIClientProtocol {
    private let authManager: NetworkManagerProtocol
    
    init(authorizationManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.authManager = authorizationManager
    }
    
    func fetch<T: Codable>(request: EndPointType, basePath: String, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy, completionHandler: @escaping ((Result<T, NetworkError>) -> Void)) {
        self.authManager.startRequest(request: request, basePath: basePath) { (data, response, error) in
            
            if let _ = error{
                let errorType = NetworkError.failed
                completionHandler(.failure(errorType))
                return
            }
            
            guard let responseData = response as? HTTPURLResponse,
                let receivedData = data else{
                    let errorType = NetworkError.noResponseData
                    completionHandler(.failure(errorType))
                    return
            }
            
            let responseStatus = self.isValidResposne(response: responseData)
            switch responseStatus {
            case .success:
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
                do {
                    let apiResponseModel = try jsonDecoder.decode(T.self, from: receivedData)
                    completionHandler(.success(apiResponseModel))
                } catch {
                    completionHandler(.failure(NetworkError.unableToDecodeResponseData(errorDescription: error.localizedDescription)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetch(request: EndPointType, basePath: String, success: @escaping NetworkSuccessHandler, failure: @escaping NetworkFailureHandler) {
        self.authManager.startRequest(request: request, basePath: basePath) { (data, response, error) in
            if let _ = error{
                let errorType = NetworkError.other(message: error?.localizedDescription)
                failure(data, response, errorType)
                return
            }
            
            guard let responseData = response as? HTTPURLResponse,
                let receivedData = data else{
                    let errorType = NetworkError.noResponseData
                    failure(data, response, errorType)
                    return
            }
            
            let responseStatus = self.isValidResposne(response: responseData)
            switch responseStatus {
            case .success:
                success(receivedData, response)
            case .failure(let error):
                failure(data, response, error)
            }
        }
    }
    
    func isValidResposne(response: HTTPURLResponse) -> Result<String, NetworkError>{
        switch response.statusCode{
        case 200...299:
            return .success("Valid Response")
        case 401:
            return .failure(NetworkError.authenticationError)
        case 500:
            return .failure(NetworkError.badRequest)
        default:
            return .failure(NetworkError.failed)
        }
    }
}

extension APIClient {
    func getProductListwert() {
        let apiData = ProductRequest.getProductList
        fetch(request: apiData, basePath: NetworkConstant.ProductBase.url, success: { (data, result) in
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let productList = try decoder.decode([Product].self, from: data)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }) { (data, result, error) in
            print("Error", error.localizedDescription)
        }
    }
}
