//
//  AppLinker.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

/// Class that handles deeplinks and push notifications.
/// It implements the singleton pattern so that the same instance can be accessed from anywhere.
public class AppLinker {
    public static var instance = AppLinker()

    /// The list of links that should be matched against the content that is received by the AppLinker.
    private let links: [Link] = [HomeLinkTarget.createLink(), RecipeLinkTarget.createLink()]

    /// Try to parse the content and trigger the corresponding action.
    /// The method tries to parse the content as one of the registered links and, if the parsing is successful, the link's action is triggered.
    /// - Parameter content: The content that should be parsed. It can either be a url (deeplink) or a dictionary of strings/strings (push notification).
    public func handle(content: Any) {
        let matchedLink = links.first { $0.canLink(content: content) }
        matchedLink?.performAction(content: content)
    }
}
