//
//  EndPointType.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation

protocol EndPointType {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParams { get }
    var headers: [String: String]? { get }
    var dataType: ResponseDataType { get }
    func absolutePath(from basePath: String) -> String
}

extension EndPointType {
    func absolutePath(from basePath: String) -> String {
        return basePath + path
    }
}
