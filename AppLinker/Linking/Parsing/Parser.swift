//
//  Parser.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

protocol Parser {
    associatedtype ContentType
    
    func parse(content: ContentType) -> Payload?
}
