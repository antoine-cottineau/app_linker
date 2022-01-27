//
//  Deeplink.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

import Foundation

/// Struct that holds the information related to a deeplink.
struct Deeplink {
    let type: LinkType
    let parameters: [String: String]
    let url: URL
}
