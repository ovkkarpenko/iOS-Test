//
//  DummyViewController.swift
//  iOS-Test
//

import UIKit
import StoreKit

protocol DummyDisplayLogic: AnyObject {
    func display(model: DummyModels.Load.ViewModel)
    
    func showRequestReview()
}

class DummyViewController: UIViewController {
    var interactor: DummyBusinessLogic?
    var router: DummyRoutingLogic?
    
    // MARK: - Outlets
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.load(request: .init())
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactor?.viewWillAppear()
    }
    
    // MARK: - Common
    func setupUI() {
        self.navigationItem.title = "Hello world!"
    }
}

extension DummyViewController: DummyDisplayLogic {
    func display(model: DummyModels.Load.ViewModel) {
        
    }
    
    func showRequestReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
