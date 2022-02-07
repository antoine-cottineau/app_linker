//
//  ActionFactory.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

// A class used to create an instance of `Action`.
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
