//
//  NetworkManagerProtocol.swift
//  Artium
//
//  Created by Dileep Jaiswal on 13/04/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func startRequest(request: EndPointType, basePath: String, completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)
}
