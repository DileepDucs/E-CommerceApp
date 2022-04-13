//
//  SearchRequest.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation

enum SearchRequest {
    case searchByName(_: String)
}

extension SearchRequest: EndPointType {
    var path: String {
        switch self {
        case .searchByName(let name):
            return "search/repositories?q=\(name)&page=1&per_page=30"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchByName:
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
