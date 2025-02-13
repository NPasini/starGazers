//
//  StarGazersListRouterTests.swift
//  starGazers
//
//  Created by nicolo.pasini on 13/02/25.
//

@testable import starGazers
import Testing
import UIKit

struct StarGazersListRouterTests {
    let sut: StarGazersListRouter
    private let navigationController: NavigationControllerMock
    
    @MainActor
    init() {
        navigationController = NavigationControllerMock()
        sut = StarGazersListRouter()
    }
    
    @MainActor
    @Test("Showing error alert")
    func showAlert() {
        // Given
        sut.setNavigationController(navigationController)
        
        // When
        sut.showAlert(title: "Title", message: "Message", buttonTitle: "Ok")
        
        // Then
        #expect(navigationController.presentViewControllerCallCount == 1)
    }
}
