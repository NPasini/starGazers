//
//  StarGazersListPresenter.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

class StarGazersListPresenter {
    private var task: Task<Void, Error>?
    private var view: StarGazersListViewProtocol?
    private let router: StarGazersListRouterProtocol
    private let interactor: StarGazersListInteractorProtocol
    
    var title: String { "Star Gazers" }
    
    func setView(_ view: StarGazersListViewProtocol) {
        self.view = view
    }
    
    // MARK: Initializers
    
    init(interactor: StarGazersListInteractorProtocol, router: StarGazersListRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: StarGazersListPresenterProtocol

extension StarGazersListPresenter: StarGazersListPresenterProtocol {
    func viewWillAppear() {
        fetchNewStarGazers()
    }
    
    func viewWillDisappear() {
        task?.cancel()
        task = nil
    }
    
    func fetchNewStarGazers() {
        task = Task {
            do {
                view?.showSpinner()
                try await interactor.fetchStarGazers()
                view?.displayData(interactor.getStarGazers())
            } catch StarGazersListInteractor.FetchError.noMoreStarGazers {
                displayAllGazersLoadedMessage()
                view?.setHasReachEndOfData()
            } catch {
                guard !Task.isCancelled else { return }
                showErrorMessage()
            }
            
            view?.hideSpinner()
        }
    }
    
    func displayAllGazersLoadedMessage() {
        view?.displayMessage(text: Constant.allGazersLoaded)
    }
    
    func showErrorMessage() {
        router.showAlert(
            title: Constant.alertTitle,
            message: Constant.errorMessage,
            buttonTitle: Constant.okButtonTitle
        )
    }
}

// MARK: StarGazersListPresenter.Constant

private extension StarGazersListPresenter {
    enum Constant {
        static let alertTitle = "Error"
        static let okButtonTitle = "Ok"
        static let errorMessage = "Error while feetching data"
        static let allGazersLoaded = "No more Star Gazers to show"
    }
}
