//
//  HomeLinkTarget.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

/// A LinkTarget that represents the homefeed of the application
class HomeLinkTarget: LinkTarget {
    static var type: LinkType = .home

    required init?(deeplink _: Deeplink) {}

    required init?(pushNotification _: PushNotification) {}

    static func createLink() -> Link {
        return AppLink<Self> { _ in
            // Present the home feed
            MockedActionMaker.instance.lastAction = "home"
        }
    }
}
