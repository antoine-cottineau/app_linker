//
//  DeeplinkParser.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

import Foundation

class DeeplinkParser: Parser {
    func parse(content: URL) -> Payload? {
        guard let target = Target(rawValue: content.pathComponents[1]) else {
            return nil
        }
        
        var parameters = [String: String]()
        URLComponents(url: content, resolvingAgainstBaseURL: false)?.queryItems?.forEach { queryItem in
            parameters[queryItem.name] = queryItem.value
        }
        
        return Payload(target: target, parameters: parameters)
    }
}
