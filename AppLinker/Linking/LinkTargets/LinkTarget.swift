//
//  LinkTarget.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

/// A protocol that should be implemented by each type of link.
/// A LinkTarget is responsible for two things: parsing a deeplink/push notification and creating a link.
protocol LinkTarget {
    /// The type of the link.
    static var type: LinkType { get }

    /// A failable initializer that constructs the instance if the inputted deeplink corresponds to the target.
    /// Otherwise, it returns nil.
    init?(deeplink: Deeplink)

    /// A failable initializer that constructs the instance if the inputted push notification corresponds to the target.
    /// Otherwise, it returns nil.
    init?(pushNotification: PushNotification)

    /// A method used to create a link for this target.
    /// - Returns: An instance of a class implementing Link.
    static func createLink() -> Link
}
