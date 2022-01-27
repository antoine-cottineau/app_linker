//
//  DeeplinkAdapter.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

import Foundation

/// An adapter that is able to parse deeplinks.
class DeeplinkAdapter: Adapter {
    func adapt<Target: LinkTarget>(content: Any) -> Target? {
        guard let urlString = content as? String,
              let url = URL(string: urlString),
              let type = LinkType(rawValue: url.pathComponents[1]),
              type == Target.type
        else {
            return nil
        }

        var parameters = [String: String]()
        URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach { queryItem in
            parameters[queryItem.name] = queryItem.value
        }

        let deeplink = Deeplink(type: type, parameters: parameters, url: url)

        return Target(deeplink: deeplink)
    }
}
