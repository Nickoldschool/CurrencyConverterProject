//
//  File.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 05.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import Foundation

public enum CurrencyApi {
    
    case base(rate: String)
    case fromBaseToCurrent(firstRate: String,secondRate: String)
    case timePeriodRate(firstRate: String, secondRate: String, startDate: String, endDate: String)
    
}

extension CurrencyApi: EndPointType {
    
    var baseURL: URL {

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.exchangeratesapi.io"
        components.path =  path
        components.queryItems = queryItems
        print(components.url?.absoluteString as Any)
        
        return components.url!
        
    }
    
    var path: String {
        switch self {
            
        case .base( _):                         // (let rate)
            return "/latest"
        case .fromBaseToCurrent( _, _):         // (let firstRate, let secondRate)
            return "/latest"
        case .timePeriodRate( _, _, _, _):      // (let firstRate, let secondRate, let startDate, let endDate)
            return "/history"
            
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .base(let rate):
            return [URLQueryItem(name: "base",     value: rate)]

        case .fromBaseToCurrent(let firstRate, let secondRate):
            return [URLQueryItem(name: "base",     value: firstRate),
                    URLQueryItem(name: "symbols",  value: secondRate)]

        case .timePeriodRate(let firstRate, let secondRate, let startDate, let endDate):
            return [URLQueryItem(name: "base",     value: firstRate),
                    URLQueryItem(name: "symbols",  value: secondRate),
                    URLQueryItem(name: "start_at", value: startDate),
                    URLQueryItem(name: "end_at",   value: endDate)]
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
         
        case .base(let rate):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: ["base"       : rate])
            
        case .fromBaseToCurrent(let firstRate , let secondRate):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: ["base"       : firstRate,
                                                      "symbols"    : secondRate])
            
        case .timePeriodRate(let firstRate, let secondRate, let startDate, let endDate):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: ["base"       : firstRate,
                                                      "symbols"    : secondRate,
                                                      "start_at"   : startDate,
                                                      "end_at"     : endDate,])

        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

