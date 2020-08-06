//
//  HTTPTask.swift
//  CurrencyConverter
//
//  Created by Nick Chekmazov on 05.08.2020.
//  Copyright © 2020 Nick Chekmazov. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                             bodyEncoding: ParameterEncoding,
                            urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                       bodyEncoding: ParameterEncoding,
                                      urlParameters: Parameters?,
                                    additionHeaders: HTTPHeaders?)
    
 
}
