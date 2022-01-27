//
//  Adapter.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

/// Protocol that any class that wants to parse some content should implement.
protocol Adapter {
    /// Parse the provided content and returns a Target if the parsing was possible.
    /// - Returns: An instance of Target.
    func adapt<Target: LinkTarget>(content: Any) -> Target?
}
