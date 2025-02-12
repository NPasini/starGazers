//
//  RepositorySelectionRouterTests.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

@testable import starGazers
import Testing
import UIKit

struct RepositorySelectionRouterTests {
    let sut: RepositorySelectionRouter
    private let httpClient: HTTPClientMock
    private let navigationController: NavigationControllerMock
    
    @MainActor
    init() {
        httpClient = HTTPClientMock()
        navigationController = NavigationControllerMock()
        sut = RepositorySelectionRouter(httpClient: httpClient)
    }
    
    @MainActor
    @Test("Navigation to Star Gazers List screen")
    func navigateToStarGazersListScreen() {
        // Given
        sut.setNavigationController(navigationController)
        
        // When
        sut.navigateToStarGazersListScreen(repoName: "Test repo", repoOwner: "Test owner")
        
        // Then
        #expect(navigationController.pushViewControllerCallCount == 1)
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

fileprivate class HTTPClientMock: HTTPClientProtocol {
    var getDataCallCount = 0
    
    func getData(from url: URL) async throws -> Data {
        getDataCallCount += 1
        return Data()
    }
}

fileprivate class NavigationControllerMock: UINavigationController {
    var pushedViewControllerArgument: UIViewController?
    var presentedViewControllerArgument: UIViewController?
    
    var pushViewControllerCallCount = 0
    var presentViewControllerCallCount = 0
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCallCount += 1
        pushedViewControllerArgument = viewController
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentViewControllerCallCount += 1
        presentedViewControllerArgument = viewControllerToPresent
    }
}
