//
//  CategoriesToDishesPresenter.swift
//  DeliciousThings
//
//  Created by MacBook on 23.06.2022.
//

import Foundation

class AllDishesPresenter {
    
    var view:PAllDishesView?
    var interactor:PAllDishesInteractor?
    var router:PAllDishesRouter?
}

extension AllDishesPresenter:PAllDishesPresenter {
    
    func viewDidLoad() {
        self.interactor?.getAllDishes()
    }
}

extension AllDishesPresenter:PAllDishesInteractorToPresenter {
    
    func getAllDishes(data: [Foods]?) {
        guard let data = data else { return }
        self.view?.getAllDishes(data: data)
    }
}
