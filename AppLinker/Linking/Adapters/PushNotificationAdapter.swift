//
//  PushNotificationAdapter.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

/// An adapter that is able to parse push notifications.
class PushNotificationAdapter: Adapter {
    func adapt<Target: LinkTarget>(content: Any) -> Target? {
        guard let parameters = content as? [String: String],
              let parsedType = parameters["type"],
              let type = LinkType(rawValue: parsedType),
              type == Target.type
        else {
            return nil
        }

        let pushNotification = PushNotification(type: type, parameters: parameters)

        return Target(pushNotification: pushNotification)
    }
}
