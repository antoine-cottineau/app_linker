//
//  MockedActionMaker.swift
//  AppLinker
//
//  Created by Antoine Cottineau on 25/01/2022.
//

/// Class used to mock the real actions an AppLinker should perform in a real application.
/// In a real application, a link could open a view controller, present a message to the user, update some user preferences...
/// In this example application, this class is used to test which action was triggered last by the AppLinker.
/// This class implements the singleton pattern.
class MockedActionMaker {
    static var instance = MockedActionMaker()

    /// The last action that any link has performed.
    var lastAction: String = ""
}
