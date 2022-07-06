//
//  CategoriesToDishesContracts.swift
//  DeliciousThings
//
//  Created by MacBook on 23.06.2022.
//

import Foundation

protocol PAllDishesView: AnyObject {
    func getAllDishes(data: [Foods]?)
}

protocol PAllDishesPresenter: AnyObject {
    // TODO: Declare presentation methods
    func viewDidLoad()
}

protocol PAllDishesInteractor: AnyObject {
    func getAllDishes()
}

protocol PAllDishesInteractorToPresenter: AnyObject {
    func getAllDishes(data: [Foods]?)
}

protocol PAllDishesRouter: AnyObject {
    // TODO: Declare wireframe methods
}
