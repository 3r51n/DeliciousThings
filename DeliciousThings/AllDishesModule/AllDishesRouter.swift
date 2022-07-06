//
//  CategoriesToDishesRouter.swift
//  DeliciousThings
//
//  Created by MacBook on 23.06.2022.
//

import Foundation
import UIKit

class AllDishesRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> AllDishesView {
        let viewController = AllDishesView()
        let presenter = AllDishesPresenter()
        let router = AllDishesRouter()
        let interactor = AllDishesInteractor()

        viewController.presenter =  presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.presenter = presenter

        return viewController
    }
}

extension AllDishesRouter: PAllDishesRouter {
    // TODO: Implement wireframe methods
}
