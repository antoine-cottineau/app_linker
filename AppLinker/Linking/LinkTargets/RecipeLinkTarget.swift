//
//  RecipeLinkTarget.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

/// A LinkTarget that represents the various screens that relate to recipes.
class RecipeLinkTarget: LinkTarget {
    static var type: LinkType = .recipe

    private let id: String?
    private let country: String?
    private let limit: Int?

    required init?(deeplink: Deeplink) {
        id = deeplink.parameters["id"]
        country = deeplink.parameters["country"]
        if let limitValue = deeplink.parameters["limit"] {
            limit = Int(limitValue)
        } else {
            limit = nil
        }
    }

    required init?(pushNotification: PushNotification) {
        id = pushNotification.parameters["id"]
        country = pushNotification.parameters["country"]
        if let limitValue = pushNotification.parameters["limit"] {
            limit = Int(limitValue)
        } else {
            limit = nil
        }
    }

    static func createLink() -> Link {
        return AppLink<Self> { target in
            // Use the parameters of target to present some recipes
            var action = "recipe"
            if let id = target.id {
                action += " id=\(id)"
            }
            if let country = target.country {
                action += " country=\(country)"
            }
            if let limit = target.limit {
                action += " limit=\(limit)"
            }
            MockedActionMaker.instance.lastAction = action
        }
    }
}
