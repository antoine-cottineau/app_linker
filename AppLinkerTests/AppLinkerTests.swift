//
//  AppLinkerTests.swift
//  AppLinkerTests
//
//  Created by Antoine Cottineau on 25/01/2022.
//

@testable import AppLinker
import XCTest

class AppLinkerTests: XCTestCase {
    func testHome() {
        AppLinker.instance.handleDeeplink(url: URL(string: "https://bestrecipes.com/home")!)
        XCTAssertEqual(MockedActionMaker.instance.lastAction, "home")

        AppLinker.instance.handlePushNotification(content: ["type": "home"])
        XCTAssertEqual(MockedActionMaker.instance.lastAction, "home")
    }

    func testRecipeHome() {
        AppLinker.instance.handleDeeplink(url: URL(string: "https://bestrecipes.com/recipe")!)
        XCTAssertEqual(MockedActionMaker.instance.lastAction, "recipe")

        AppLinker.instance.handlePushNotification(content: ["type": "recipe"])
        XCTAssertEqual(MockedActionMaker.instance.lastAction, "recipe")
    }

    func testRecipeById() {
        AppLinker.instance.handleDeeplink(url: URL(string: "https://bestrecipes.com/recipe?id=1234")!)
        XCTAssertEqual(MockedActionMaker.instance.lastAction, "recipe id=1234")

        AppLinker.instance.handlePushNotification(content: ["type": "recipe", "id": "1234"])
        XCTAssertEqual(MockedActionMaker.instance.lastAction, "recipe id=1234")
    }

    func testRecipeByCountry() {
        AppLinker.instance.handleDeeplink(url: URL(string: "https://bestrecipes.com/recipe?country=FR")!)
        XCTAssertEqual(MockedActionMaker.instance.lastAction, "recipe country=FR")

        AppLinker.instance.handlePushNotification(content: ["type": "recipe", "country": "FR"])
        XCTAssertEqual(MockedActionMaker.instance.lastAction, "recipe country=FR")
    }

    func testRecipeByCountryAndLimit() {
        AppLinker.instance.handleDeeplink(url: URL(string: "https://bestrecipes.com/recipe?country=FR&limit=7")!)
        XCTAssertEqual(MockedActionMaker.instance.lastAction, "recipe country=FR limit=7")

        AppLinker.instance.handlePushNotification(content: ["type": "recipe", "country": "FR", "limit": "7"])
        XCTAssertEqual(MockedActionMaker.instance.lastAction, "recipe country=FR limit=7")
    }
}
