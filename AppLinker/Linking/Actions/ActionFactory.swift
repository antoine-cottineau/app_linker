//
//  ActionFactory.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

class ActionFactory {
    func createAction(payload: Payload) -> Action {
        switch payload.target {
        case .home:
            return HomeAction()
        case .recipe:
            return RecipeAction()
        }
    }
}
