//
//  DummyInteractor.swift
//  iOS-Test
//

import Foundation

// Implemented by Interactor
protocol DummyBusinessLogic {
    // Loads the list of the items and passes Load.Response to Presenter
    func load(request: DummyModels.Load.Request)
    func viewWillAppear()
}

class DummyInteractor {
    private let lastReviewRequestKey = "lastReviewRequestDate"
    
    var presenter: DummyPresentationLogic?
}

extension DummyInteractor: DummyBusinessLogic {
    func load(request: DummyModels.Load.Request) {
        presenter?.present(response: .init())
    }
    
    func viewWillAppear() {
        let canRequestReview: Bool = Services.reviewRequest.canRequestReview(hasOpenedDummyScreen: true)
        
        if canRequestReview {
            presenter?.requestReview()
        }
    }
}
