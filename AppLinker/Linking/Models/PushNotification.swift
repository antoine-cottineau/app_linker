//
//  PushNotification.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

/// Struct that holds the information related to a push notification.
struct PushNotification {
    let type: LinkType
    let parameters: [String: String]
}
