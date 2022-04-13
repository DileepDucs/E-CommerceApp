//
//  ProductRequest.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation

enum ProductRequest {
    case getProductList
    case getProductDetail(productId: Int)
}

extension ProductRequest: EndPointType {
    var path: String {
        switch self {
        case .getProductList:
            return "products"
        case .getProductDetail(let productId):
            return "products/" + "\(productId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProductList, .getProductDetail(_):
            return .get
        }
    }
    
    var parameters: RequestParams {
        return RequestParams(urlParameters: nil, bodyParameters: nil)
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var dataType: ResponseDataType {
        return .JSON
    }
}
