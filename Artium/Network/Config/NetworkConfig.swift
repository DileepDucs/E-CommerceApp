//
//  NetworkConfig.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation

public enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    case patch
}

public enum ResponseDataType {
    case Data
    case JSON
}

public enum Encoding: String {
    case URL
    case JSON
}

enum HeaderContentType: String {
    case json = "application/json"
}

enum HTTPHeaderKeys: String {
    case contentType = "Content-Type"
    case cookie = "Cookie"
}


public struct RequestParams {
    var urlParameters: [String: String]?
    let bodyParameters: [String: Any]?
    let contentType: HeaderContentType
    
    init(urlParameters: [String: String]?, bodyParameters: [String: Any]?, contentType: HeaderContentType = .json) {
        self.urlParameters = urlParameters
        self.bodyParameters = bodyParameters
        self.contentType = contentType
    }
}
