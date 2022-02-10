//
//  PayloadHandler.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 10/02/2022.
//

/// Class responsible for handling payloads.
/// Run the action corresponding to the payload by calling `runAction`.
class PayloadHandler {
    /// The payload to handle.
    let payload: Payload
    
    init(_ payload: Payload) {
        self.payload = payload
    }
    
    /// Run the action that corresponds to the `payload`.
    func runAction() {
        switch payload.target {
        case .home:
            runForHome()
        case .recipe:
            runForRecipes()
        }
    }
    
    private func runForHome() {
        MockedActionMaker.instance.lastAction = "home"
    }
    
    private func runForRecipes() {
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
