//
//  HomeViperTemplateRouter.swift
//  DeliciousThings
//
//  Created by MacBook on 21.06.2022.
//  
//

import Foundation
import UIKit

class HomeRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> HomeView {
        let viewController = HomeView()
        let presenter = HomePresenter()
        let router = HomeRouter()
        let interactor = HomeInteractor()

        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension HomeRouter: PHomepRouter {
    // TODO: Implement wireframe methods
}
