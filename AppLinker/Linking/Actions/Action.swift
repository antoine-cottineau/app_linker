//
//  Action.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 03/02/2022.
//

// A simple protocol describing what an action should be able to perform.
// An action could for example be "Open the Recipe view controller".
protocol Action {
    /// Use the `payload` to perform an action.
    func run(payload: Payload)
}
