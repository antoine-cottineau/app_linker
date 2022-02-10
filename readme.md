# Organizing your app to handle deeplinks and push notifications

This article presents a way to organize in the same module the code for handling deeplinks and the code for handling push notifications. The code that is presented is written in Swift and for iOS but the architecture of the module and the logic of the code can be transposed to other languages and technologies.

The code is available at https://github.com/antoine-cottineau/app_linker.

## Table of contents

1. Deeplinks and push notifications
2. A simple example
3. The module
4. Conclusion

## 1. Deeplinks and push notifications

Before diving into how the module is structured, let's briefly describe what deeplinks and push notifications are.

A deeplink is a special kind of link that, when opened in the browser of a mobile phone, opens a specific screen of a native application. For example, for a company that provides a website and an application dedicated to weather forecasts, a deeplink could be used to open the screen of the app that shows the weather forecast for a specific day. If the user doesn't have the app installed or isn't on mobile, then the corresponding webpage can be opened in the browser. On iOS, deeplinks are called [universal links](https://developer.apple.com/ios/universal-links/) but we'll keep the term deeplink because it is more general.

A push notification is a piece of data that can be sent from a backend to a mobile device. It often provides information to the user and can also encourage them to act. For example, a football app may send push notifications to its users whenever a player is transferred from one club to another. By tapping on the push notification, the user would expect the app to open a screen that shows information about the transfer.

Both deeplinks and push notifications are a good way to enrich an app. As the action performed when opening a deeplink or when tapping a push notification is often the same, it makes sense to create a single module for handling both structures.

## 2. A simple example

To keep the implementation concrete, we choose to design the module for a fictional recipe app called `bestrecipes`. This app could for example contain recipes that are posted by chefs, a way for the user to follow chefs, a grading system for the recipes...

We'll focus on implementing deeplinks and push notifications that can either link to a home feed or to a "recipes" screen. Here are some examples of possible deeplinks and push notifications:

### Home

Deeplink: `https://bestrecipes.com/home`

Push notification:
```json
{"type": "home"}
```

### Recipe by id

Deeplink: `https://bestrecipes.com/recipe?id=1234`

Push notification:
```json
{"type": "recipe", "id": "1234"}
```

### Recipes by country and with a limit
Deeplink: `https://bestrecipes.com/recipe?country=FR&limit=7`

Push notification:
```json
{"type": "recipe", "country": "FR", "limit": 7}
```

## 3. The module

The following picture is a UML class diagram of the module:

![UML class diagram](./images/app_linker.png)

We'll study the various parts of the module in the following sections.

### 3.1 Models

As deeplinks and push notifications can be used to perform the same actions, they should also be able to contain the same information. So, instead of creating a model for deeplinks and one for push notifications, we abstract the concepts in a `Payload` structure.

```swift
// Payload.swift
struct Payload {
    let target: Target
    let parameters: [String: String]
}
```

As you can see, a `Payload` keeps a dictionary of parameters and has a field of type `Target`, which is just an enum that lists all the possible screens that can be reached by a deeplink or a push notification:

```swift
// Target.swift
enum Target: String {
    case home
    case recipe
}
```

 In our example, we only support two screens (home and recipes) but we can always extend the module by adding more cases.

### 3.2 Parsing

The first action the module should perform is to parse the incoming deeplink or push notification into an instance of `Payload`. To do so, we define a protocol that describes the ability to parse an object into a `Payload`:

```swift
// Parser.swift
protocol Parser {
    associatedtype InputType

    /// Parse the `content` into a `Payload`.
    /// If the `content` is missing some required elements, the function returns nil.
    /// - Returns: An instance of `Payload` or nil if the `content` can't be parsed.
    func parse(content: InputType) -> Payload?
}
```

The associated type corresponds to the input type of the parser. For example, the following classes are implementations of `Parser` whose associated types are respectively `URL` and `[String: String]`:

```swift
// DeeplinkParser.swift
class DeeplinkParser: Parser {
    func parse(content: URL) -> Payload? {
        guard let target = Target(rawValue: content.pathComponents[1]) else {
            return nil
        }

        var parameters = [String: String]()
        URLComponents(url: content, resolvingAgainstBaseURL: false)?.queryItems?.forEach { queryItem in
            parameters[queryItem.name] = queryItem.value
        }

        return Payload(target: target, parameters: parameters)
    }
}
```

```swift
// PushNotificationParser.swift
class PushNotificationParser: Parser {
    func parse(content: [String: String]) -> Payload? {
        guard let targetString = content["target"],
              let target = Target(rawValue: targetString)
        else {
            return nil
        }
        
        return Payload(target: target, parameters: content)
    }
}
```

### 3.3 Creating actions

Once the parsing has been done, the next step is to perform the action that corresponds to the parsed `Payload`. To do so, we define a simple `Action` protocol:

```swift
// Action.swift
protocol Action {
    /// Use the `payload` to perform an action.
    func run(payload: Payload)
}
```

Each class implementing `Action` should provide a run method that performs a specific task. For example, here are `HomeAction` and `RecipeAction`:

```swift
class HomeAction: Action {
    func run(payload: Payload) {
        MockedActionMaker.instance.lastAction = "home"
    }
}
```

```swift
class RecipeAction: Action {
    func run(payload: Payload) {
        // Parse the parameters of the payload.
        let id = payload.parameters["id"]
        let country = payload.parameters["country"]
        let limit: Int?
        if let limitValue = payload.parameters["limit"] {
            limit = Int(limitValue)
        } else {
            limit = nil
        }

        // Create the action
        var action = "recipe"
        if let id = id {
            action += " id=\(id)"
        }
        if let country = country {
            action += " country=\(country)"
        }
        if let limit = limit {
            action += " limit=\(limit)"
        }
        MockedActionMaker.instance.lastAction = action
    }
}
```

Finally, we create an `ActionFactory` that is used to get the correct implementation of `Action` depending on a given `Payload`:

```swift
// ActionFactory.swift
class ActionFactory {
    /// Create an `Action` that corresponds to the `payload`.
    /// - Parameter payload: The input `Payload`.
    /// - Returns: An instance of `Action`.
    func createAction(payload: Payload) -> Action {
        switch payload.target {
        case .home:
            return HomeAction()
        case .recipe:
            return RecipeAction()
        }
    }
}
```

### 3.4 Putting things together

The final step is to combine the parsing and the creation of actions in a single place. Thus, we create an `AppLinker` which should be the entry point of the module:

```swift
// AppLinker.swift
public class AppLinker {
    public static var instance = AppLinker()

    /// Try to parse the `url` and perform the corresponding action.
    /// - Parameter url: The url to handle.
    public func handleDeeplink(url: URL) {
        guard let payload = DeeplinkParser().parse(content: url) else {
            return
        }
        handlePayload(payload)
    }

    /// Try to use the `content` to perform an action.
    /// - Parameter content: The content to use.
    public func handlePushNotification(content: [String: String]) {
        guard let payload = PushNotificationParser().parse(content: content) else {
            return
        }
        handlePayload(payload)
    }

    /// Use the `payload` to perform an action.
    /// - Parameter payload: An instance of Payload.
    private func handlePayload(_ payload: Payload) {
        let action = ActionFactory().createAction(payload: payload)
        action.run(payload: payload)
    }
}
```

The code is pretty simple: `AppLinker` has two public methods, one for handling deeplinks and the other for handling push notifications. Both methods start by parsing their input into a `Payload` and then run the corresponding action.

## 4. Conclusion

The goal of this article was to provide a possible way to architecture a single module for handling both deeplinks and push notifications. There is certainly room for improvement but the code that is presented should constitute a solid start.

To receive the content of a deeplink or a push notification, there are several steps to follow, including overwriting functions in the `AppDelegate` or the `SceneDelegate` depending on what you're using. For more information, see [this article](https://www.donnywals.com/handling-deeplinks-in-your-app/) for implementing deeplinks and [this one](https://medium.com/fenrir-inc/handling-ios-push-notifications-the-not-so-apparent-side-420891ddf10b) for push notifications.

Finally, I would like to thank [David Rico](https://www.linkedin.com/in/davidricomobile). We both worked on the module and I learned a lot by working with him.