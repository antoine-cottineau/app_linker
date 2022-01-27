//
//  AppLink.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

/// Protocol that represents what a link should be able to do.
protocol Link {
    /// Get whether or not the content can be handled by this link.
    /// - Returns: Whether or not the content can be handled by this link.
    func canLink(content: Any) -> Bool

    /// Perform an action that corresponds to the inputted content.
    func performAction(content: Any)
}

/// A class implementing the Link protocol. It contains an action that can be performed by calling performAction.
class AppLink<Target: LinkTarget>: Link {
    /// The action that the link performs.
    private let action: (Target) -> Void

    init(action: @escaping (Target) -> Void) {
        self.action = action
    }

    func canLink(content: Any) -> Bool {
        let adapterResults: [Target?] = [DeeplinkAdapter().adapt(content: content), PushNotificationAdapter().adapt(content: content)]
        return !adapterResults.compactMap { $0 }.isEmpty
    }

    func performAction(content: Any) {
        let adapterResults: [Target?] = [DeeplinkAdapter().adapt(content: content), PushNotificationAdapter().adapt(content: content)]
        if let target = adapterResults.compactMap({ $0 }).first {
            action(target)
        }
    }
}
