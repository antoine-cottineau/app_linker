//
//  PushNotificationParser.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

// A `Parser` that takes dictionaries of type `[String: String]` as input.
class PushNotificationParser: Parser {
    func parse(content: [String: String]) -> Payload? {
        guard let targetString = content["target"],
              let target = Target(rawValue: targetString)
        else {
            return nil
        }
        
        return Payload(target: target, parameters: content)
    }
}
