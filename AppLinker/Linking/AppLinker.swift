//
//  AppLinker.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

import Foundation

/// Class that handles deeplinks and push notifications.
/// It implements the singleton pattern so that the same instance can be accessed from anywhere.
public class AppLinker {
    public static var instance = AppLinker()

    /// Try to parse the `url` and perform the corresponding action.
    /// - Parameter url: The url to handle.
    public func handleDeeplink(url: URL) {
        guard let payload = DeeplinkParser().parse(content: url) else {
            return
        }
        PayloadHandler(payload).runAction()
    }

    /// Try to use the `content` to perform an action.
    /// - Parameter content: The content to use.
    public func handlePushNotification(content: [String: String]) {
        guard let payload = PushNotificationParser().parse(content: content) else {
            return
        }
        PayloadHandler(payload).runAction()
    }
}
