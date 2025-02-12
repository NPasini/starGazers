//
//  RepositorySelectionPresenterTests.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

@testable import starGazers
import Testing

struct RepositorySelectionPresenterTests {
    private let router: RouterMock
    let sut: RepositorySelectionPresenter
    
    init() {
        router = RouterMock()
        sut = RepositorySelectionPresenter(
            model: RepositorySelectionModel(),
            router: router
        )
    }
    
    @Test("Tapping on confirm button without setting repo name")
    mutating func setTapConfirmWithoutRepoName() {
        // Given
        let newRepoOwner = "Test Owner"
        
        // When
        sut.setRepositoryOwner(newRepoOwner)
        sut.didTapOnConfirmButton()
        
        // Then
        #expect(router.showAlertCallsCount == 1)
        #expect(router.navigateToStarGazersListScreenCallsCount == 0)
        
        // When
        sut.didTapOnConfirmButton()
        
        // Then
        #expect(router.showAlertCallsCount == 2)
        #expect(router.navigateToStarGazersListScreenCallsCount == 0)
    }
    
    @Test("Tapping on confirm button without setting repo owner")
    mutating func setTapConfirmWithoutRepoOwner() {
        // Given
        let newRepoName = "Test Repo"
        
        // When
        sut.setRepositoryName(newRepoName)
        sut.didTapOnConfirmButton()
        
        // Then
        #expect(router.showAlertCallsCount == 1)
        #expect(router.navigateToStarGazersListScreenCallsCount == 0)
        
        // When
        sut.didTapOnConfirmButton()
        
        // Then
        #expect(router.showAlertCallsCount == 2)
        #expect(router.navigateToStarGazersListScreenCallsCount == 0)
    }
    
    @Test("Tapping on confirm button after setting repo owner and name")
    mutating func setTapConfirmWithRepoOwnerAndName() {
        // Given
        let newRepoName = "Test Repo"
        let newRepoOwner = "Test Owner"
        
        // When
        sut.setRepositoryName(newRepoName)
        sut.setRepositoryOwner(newRepoOwner)
        sut.didTapOnConfirmButton()
        
        // Then
        #expect(router.showAlertCallsCount == 0)
        #expect(router.navigateToStarGazersListScreenCallsCount == 1)
        
        // When
        sut.didTapOnConfirmButton()
        
        // Then
        #expect(router.showAlertCallsCount == 0)
        #expect(router.navigateToStarGazersListScreenCallsCount == 2)
    }
}

fileprivate class RouterMock: RepositorySelectionRouterProtocol {
    var showAlertCallsCount = 0
    var navigateToStarGazersListScreenCallsCount = 0
    
    func navigateToStarGazersListScreen(repoName: String, repoOwner: String) {
        navigateToStarGazersListScreenCallsCount += 1
    }
    
    func showAlert(title: String, message: String, buttonTitle: String) {
        showAlertCallsCount += 1
    }
}
