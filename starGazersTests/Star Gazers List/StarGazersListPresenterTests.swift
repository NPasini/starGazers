//
//  StarGazersListPresenterTests.swift
//  starGazers
//
//  Created by nicolo.pasini on 13/02/25.
//

@testable import starGazers
import Testing
import UIKit

struct StarGazersListPresenterTests {
    let sut: StarGazersListPresenter
    private let view: StarGazersListViewProtocolMock
    private let router: StarGazersListRouterProtocolMock
    private let interactor: StarGazersListInteractorProtocolMock
    
    init() {
        view = StarGazersListViewProtocolMock()
        router = StarGazersListRouterProtocolMock()
        interactor = StarGazersListInteractorProtocolMock()
        sut = StarGazersListPresenter(
            interactor: interactor,
            router: router
        )
        sut.setView(view)
    }
    
    @Test("View will appear fetch data from interactor")
    func viewWillAppear() async {
        await withCheckedContinuation { continuation in
            interactor.fetchStarGazersClosure = {
                continuation.resume()
            }
            
            sut.viewWillAppear()
        }
        
        #expect(interactor.fetchStarGazersCallCount == 1)
    }
    
    @Test("Fetch New StarGazers fetch data from interactor and notifies view when receiving valid data")
    func fetchNewStarGazers() async {
        // When
        await withCheckedContinuation { continuation in
            view.hideSpinnerClosure = {
                continuation.resume()
            }
            
            sut.fetchNewStarGazers()
        }
        
        // Then
        #expect(view.showSpinnerCallCount == 1)
        #expect(view.hideSpinnerCallCount == 1)
        #expect(view.displayDataCallCount == 1)
        #expect(router.showAlertCallsCount == 0)
        #expect(view.displayMessageCallCount == 0)
        #expect(view.setHasReachEndOfDataCallCount == 0)
        #expect(interactor.fetchStarGazersCallCount == 1)
    }
    
    @Test("Fetch New StarGazers fetch data from interactor and notifies view when there are no more star gazers")
    func fetchNewStarGazersWhenReachingTheEndOfList() async {
        // Given
        interactor.fetchStarGazersError = StarGazersListInteractor.FetchError.noMoreStarGazers
        
        // When
        await withCheckedContinuation { continuation in
            view.hideSpinnerClosure = {
                continuation.resume()
            }
            
            sut.fetchNewStarGazers()
        }
        
        // Then
        #expect(view.showSpinnerCallCount == 1)
        #expect(view.hideSpinnerCallCount == 1)
        #expect(router.showAlertCallsCount == 0)
        #expect(view.displayMessageCallCount == 1)
        #expect(view.setHasReachEndOfDataCallCount == 1)
        #expect(interactor.fetchStarGazersCallCount == 1)
    }
    
    @Test("Fetch New StarGazers fetch data from interactor and kills the task on view will disappear")
    func fetchNewStarGazersAndViewDisappear() async {
        // When
        await withCheckedContinuation { continuation in
            view.hideSpinnerClosure = {
                continuation.resume()
            }
            
            sut.fetchNewStarGazers()
            sut.viewWillDisappear()
        }
        
        // Then
        #expect(view.showSpinnerCallCount == 1)
        #expect(view.hideSpinnerCallCount == 1)
        #expect(router.showAlertCallsCount == 0)
        #expect(view.displayMessageCallCount == 0)
        #expect(view.setHasReachEndOfDataCallCount == 0)
        #expect(interactor.fetchStarGazersCallCount == 1)
    }
    
    @Test("Fetch New StarGazers fetch data from interactor and generic error happen")
    func fetchNewStarGazersAndGenericErrorHappen() async {
        // Given
        interactor.fetchStarGazersError = NSError()
        
        // When
        await withCheckedContinuation { continuation in
            view.hideSpinnerClosure = {
                continuation.resume()
            }
            
            sut.fetchNewStarGazers()
        }
        
        // Then
        #expect(view.showSpinnerCallCount == 1)
        #expect(view.hideSpinnerCallCount == 1)
        #expect(router.showAlertCallsCount == 1)
        #expect(view.displayMessageCallCount == 0)
        #expect(view.setHasReachEndOfDataCallCount == 0)
        #expect(interactor.fetchStarGazersCallCount == 1)
    }
    
    @Test("Display all gazers loaded message notify view")
    func displayAllGazersLoadedMessage() {
        // When
        sut.displayAllGazersLoadedMessage()
        
        // Then
        #expect(view.displayMessageCallCount == 1)
    }
    
    @Test("Show error message notify view")
    func showErrorMessage() {
        // When
        sut.showErrorMessage()
        
        // Then
        #expect(router.showAlertCallsCount == 1)
    }
}

fileprivate class StarGazersListInteractorProtocolMock: StarGazersListInteractorProtocol {
    private var starGazers: [StarGazer] = []
    
    var getStarGazersCallCount = 0
    var fetchStarGazersCallCount = 0
    
    var fetchStarGazersError: Error?
    var fetchStarGazersClosure: (() -> Void)?
    
    func setStarGazers(_ starGazers: [StarGazer]) {
        self.starGazers = starGazers
    }
    
    func getStarGazers() -> [StarGazer] {
        getStarGazersCallCount += 1
        return starGazers
    }
    
    func fetchStarGazers() async throws {
        fetchStarGazersCallCount += 1
        fetchStarGazersClosure?()
        if let error = fetchStarGazersError {
            throw error
        }
    }
}

fileprivate class StarGazersListRouterProtocolMock: StarGazersListRouterProtocol {
    var showAlertCallsCount = 0
    var setNavigationControllerCallsCount = 0
    
    func setNavigationController(_ navigationController: UINavigationController) {
        setNavigationControllerCallsCount += 1
    }
    
    func showAlert(title: String, message: String, buttonTitle: String) {
        showAlertCallsCount += 1
    }
}

fileprivate class StarGazersListViewProtocolMock: StarGazersListViewProtocol {
    var showSpinnerCallCount = 0
    var hideSpinnerCallCount = 0
    var displayDataCallCount = 0
    var displayMessageCallCount = 0
    var setHasReachEndOfDataCallCount = 0
    
    var hideSpinnerClosure: (() -> Void)?
    
    func showSpinner() {
        showSpinnerCallCount += 1
    }
    
    func hideSpinner() {
        hideSpinnerCallCount += 1
        hideSpinnerClosure?()
    }
    
    func setHasReachEndOfData() {
        setHasReachEndOfDataCallCount += 1
    }
    
    func displayMessage(text: String) {
        displayMessageCallCount += 1
    }
    
    func displayData(_ starGazers: [starGazers.StarGazer]) {
        displayDataCallCount += 1
    }
}
