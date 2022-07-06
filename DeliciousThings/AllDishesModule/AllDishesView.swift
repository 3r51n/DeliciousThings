//
//  CategoriesToDishesView.swift
//  DeliciousThings
//
//  Created by MacBook on 23.06.2022.
//

import Foundation
import UIKit

class AllDishesView:UIViewController {
    
    // MARK: Properties
    var presenter:PAllDishesPresenter?
    var data:[Foods] = []
    
    private var tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(AllDishesCell.self, forCellReuseIdentifier: AllDishesCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let searchController:UISearchController = {
        
        let controller = UISearchController(searchResultsController: SearchResultVC())
        controller.searchBar.placeholder = "Search for a Delicious"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubview()
        configureView()
    }
    
}

extension AllDishesView:PAllDishesView {
    
    func getAllDishes(data: [Foods]?) {
        guard let data = data else { return }
        self.data += data
        self.data.shuffle()
        self.tableView.reloadData()
    }
}

// MARK: - UILayout
extension AllDishesView {
    
    private func addSubview() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}

// MARK: - ConfigureContents
extension AllDishesView {
    
    private func configureView() {
        presenter?.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "All Dishes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.tintColor = .label
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
}

extension AllDishesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AllDishesCell.identifier, for: indexPath) as! AllDishesCell
        
        let food = data[indexPath.row]
        cell.setup(food: food)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = data[indexPath.row]
        let vc = DishDetailVC()
        vc.dish = food
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension AllDishesView: UISearchResultsUpdating, PToDetail {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
                !query.trimmingCharacters(in: .whitespaces).isEmpty,
        let resultController = searchController.searchResultsController as? SearchResultVC
        else { return }
        resultController.data.removeAll()
        resultController.data = self.data.filter({ data in
            data.name!.lowercased().contains(query.lowercased())
        })
        resultController.tableView.reloadData()
        
        resultController.pushProtocol = self
        
    }
    func toDetail(food: Foods) {
        let vc = DishDetailVC()
        vc.dish = food
        navigationController?.pushViewController(vc, animated: true)
    }
}
