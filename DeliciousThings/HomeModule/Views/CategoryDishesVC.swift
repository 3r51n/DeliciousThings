//
//  CategoryDishesVC.swift
//  DeliciousThings
//
//  Created by MacBook on 4.07.2022.
//

import Foundation
import UIKit

class CategoryDishesVC:UIViewController {
    
    private var data:[Foods] = []
    static let shared = CategoryDishesVC()
    
    private var tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryDishCell.self, forCellReuseIdentifier: CategoryDishCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public func setup(data: [Foods]) {
        self.data = data
        self.tableView.reloadData()
    }
}

extension CategoryDishesVC:UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryDishCell.identifier, for: indexPath) as! CategoryDishCell
        
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
