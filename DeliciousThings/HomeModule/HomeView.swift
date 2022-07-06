//
//  HomeViperTemplateViewController.swift
//  DeliciousThings
//
//  Created by MacBook on 21.06.2022.
//  
//

import Foundation
import UIKit


class HomeView: UIViewController{
    

    // MARK: Properties
    
    var presenter: PHomepPresenter?
    private var categoryData:[Foods] = []
    
    var categoryView:FoodCategoryView = {
        return FoodCategoryView()
    }()
    
    var popularDishesView:PopularDishesView = {
        return PopularDishesView()
    }()
    
    var chefSpecialsView:ChefSpecialsView = {
        return ChefSpecialsView()
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        configureContents()
    }
}

extension HomeView: PHomepView {
    
    func getCategorys(data: AllDishes?) {
        guard let data = data else { return }
        categoryView.setup(data: data.categories!)
        popularDishesView.setup(data: data.populars!)
        chefSpecialsView.setup(data: data.specials!)
    }
    
    func getCategoryDishes(data: [Foods]?) {
        guard let data = data else { return }
        let vc = CategoryDishesVC()
        navigationController?.pushViewController(vc, animated: true)
        DispatchQueue.main.async {
            vc.setup(data: data)
        }
    }
}

// MARK: - UILayout
extension HomeView {
    
    private func addSubviews() {
        addCategoryView()
        addPopularView()
        addChefSpecialsView()
    }
    
    private func addCategoryView() {
        view.addSubview(categoryView)
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            categoryView.heightAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.height/10)*2.3)
        ])
    }
    
    private func addPopularView() {
        view.addSubview(popularDishesView)
        NSLayoutConstraint.activate([
            popularDishesView.topAnchor.constraint(equalTo: categoryView.bottomAnchor),
            popularDishesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            popularDishesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            popularDishesView.heightAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.height/10)*3.5)
        ])
    }
    
    private func addChefSpecialsView(){
        view.addSubview(chefSpecialsView)
        NSLayoutConstraint.activate([
            chefSpecialsView.topAnchor.constraint(equalTo: popularDishesView.bottomAnchor),
            chefSpecialsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chefSpecialsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            chefSpecialsView.heightAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.height/10)*2)
        ])
    }
}

// MARK: - ConfigureContents
extension HomeView:ProtocolPushToDetailPopular, ProtocolPushToDetailChef, ProtocolPushToCategoryDish {
    
    private func configureContents() {
        configureView()
        presenter?.viewDidLoad()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        navigationItem.title = "Delicious Things"
        popularDishesView.pushProtocol = self
        chefSpecialsView.pushProtocol = self
        categoryView.pushProtocol = self
    }
    
    func pushDetailChef(dish: Foods) {
        let vc = DishDetailVC()
        vc.dish = dish
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushDetailPopular(dish: Foods) {
        let vc = DishDetailVC()
        vc.dish = dish
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushCategoryDish(catName: String) {
        self.presenter?.viewDidLoadCategoryDishes(catName: catName)
        
    }
}
