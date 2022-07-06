//
//  HomeViperTemplateContract.swift
//  DeliciousThings
//
//  Created by MacBook on 21.06.2022.
//  
//

import Foundation

protocol PHomepView: AnyObject {
    func getCategorys(data: AllDishes?)
    func getCategoryDishes(data: [Foods]?)
}

protocol PHomepPresenter: AnyObject {
    // TODO: Declare presentation methods
    func viewDidLoad()
    func viewDidLoadCategoryDishes(catName:String)
}

protocol PHomepInteractor: AnyObject {
    func getCategorys()
    func getCategoryDishes(catName:String)
}

protocol PHomepInteractorToPresenter: AnyObject {
    func getCategorys(data: AllDishes?)
    func getCategoryDishes(data:[Foods]?)
}

protocol PHomepRouter: AnyObject {
    // TODO: Declare wireframe methods
}
