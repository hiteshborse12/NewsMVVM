//
//  ApiRequest.swift
//  News
//
//  Created by Neosoft on 11/08/22.
//

import Foundation
import Alamofire

protocol ApiRequest {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: HTTPHeaders? { get }
    var encoding: ParameterEncoding { get }
}
