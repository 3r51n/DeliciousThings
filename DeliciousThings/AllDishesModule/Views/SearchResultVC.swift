//
//  SearchResultVC.swift
//  DeliciousThings
//
//  Created by MacBook on 5.07.2022.
//

import UIKit

protocol PToDetail {
    func toDetail(food:Foods)
}

class SearchResultVC: UIViewController {
    
    var data:[Foods] = []
    var pushProtocol:PToDetail?
    
    var tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(AllDishesCell.self, forCellReuseIdentifier: AllDishesCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        configureView()
    }

}
// MARK: - UILayout
extension SearchResultVC {
    
    private func addSubview() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}

// MARK: - ConfigureContents
extension SearchResultVC {
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
}

extension SearchResultVC: UITableViewDelegate, UITableViewDataSource {
    
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
        pushProtocol?.toDetail(food: data[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
