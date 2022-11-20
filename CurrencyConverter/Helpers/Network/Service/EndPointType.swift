//
//  EndPointType.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 05.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var queryItems: [URLQueryItem] { get}
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
