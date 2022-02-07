//
//  HomeAction.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

class HomeAction: Action {
    func run(payload: Payload) {
        MockedActionMaker.instance.lastAction = "home"
    }
}
