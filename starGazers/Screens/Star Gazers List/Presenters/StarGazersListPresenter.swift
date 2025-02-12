//
//  StarGazersListPresenter.swift
//  starGazers
//
//  Created by nicolo.pasini on 12/02/25.
//

class StarGazersListPresenter {
    static let alertTitle = "Error"
    static let okButtonTitle = "Ok"
    static let errorMessage = "Error while feetching data"
    
    private var task: Task<Void, Never>?
    private let router: StarGazersListRouterProtocol
    private let interactor: StarGazersListInteractorProtocol
    
    weak var view: StarGazersListViewProtocol?
    
    var title: String { "Star Gazers" }
    
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
                try await interactor.fetchStarGazers()
                view?.displayData(interactor.getStarGazers())
            } catch {
                showErrorMessage()
            }
        }
    }
    
    func showErrorMessage() {
        router.showAlert(
            title: StarGazersListPresenter.alertTitle,
            message: StarGazersListPresenter.errorMessage,
            buttonTitle: StarGazersListPresenter.okButtonTitle
        )
    }
}
