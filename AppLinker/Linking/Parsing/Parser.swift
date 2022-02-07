//
//  Parser.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

// A protocol that every class that intends to parse an object to an instance of `Payload` should implement.
// Each `Parser` has an associatedtype called `InputType` that corresponds to the type of the objects
// the parser parses. It can for example be `URL` for deeplinks or `[String: String]` for push notifications.
protocol Parser {
    associatedtype InputType

    /// Parse the `content` into a `Payload`.
    /// If the `content` is missing some required elements, the function returns nil.
    /// - Returns: An instance of `Payload` or nil if the `content` can't be parsed.
    func parse(content: InputType) -> Payload?
}
