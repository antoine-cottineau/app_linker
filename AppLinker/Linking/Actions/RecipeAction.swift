//
//  RecipeAction.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

/// An `Action` that is able to open the recipe screen.
/// The parameters `id`, `country` and `limit` can be used to filter the recipes that should be displayed.
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
