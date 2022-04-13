//
//  CategoryRequest.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation

enum CategoryRequest {
    case getProductCategories
    case getProductCategory(category: String)
}

extension CategoryRequest: EndPointType {
    var path: String {
        switch self {
        case .getProductCategories:
            return "products/categories"
        case .getProductCategory(let category):
            return "products/category/" + "\(category)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProductCategories, .getProductCategory(_):
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
