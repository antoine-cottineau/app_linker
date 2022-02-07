//
//  Payload.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

// A struct that represents the result of the parsing of a deeplink or a push notification.
struct Payload {
    /// The target corresponding to the screen the payload should open.
    let target: Target

    /// A dictionary of parameters.
    let parameters: [String: String]
}
