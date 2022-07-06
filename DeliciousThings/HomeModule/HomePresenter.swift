//
//  HomeViperTemplatePresenter.swift
//  DeliciousThings
//
//  Created by MacBook on 21.06.2022.
//  
//

import Foundation

class HomePresenter {

    // MARK: Properties

    weak var view: PHomepView?
    var router: PHomepRouter?
    var interactor: PHomepInteractor?
    
}

extension HomePresenter: PHomepPresenter {
    // TODO: implement presentation methods
    func viewDidLoad() {
        interactor?.getCategorys()
    }
    func viewDidLoadCategoryDishes(catName:String) {
        interactor?.getCategoryDishes(catName: catName)
    }
}

extension HomePresenter: PHomepInteractorToPresenter {
    
    func getCategorys(data: AllDishes?) {
        guard let data = data else { return }
        view?.getCategorys(data: data)
    }
    func getCategoryDishes(data:[Foods]?) {
        guard let data = data else { return }
        view?.getCategoryDishes(data: data)
    }
}
