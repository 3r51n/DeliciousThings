//
//  DishDetailVC.swift
//  DeliciousThings
//
//  Created by MacBook on 23.06.2022.
//

import UIKit

class DishDetailVC: UIViewController {
    
    var dish:Foods?
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private let image:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        
        return image
    }()
    
    private let caloriesLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .systemRed
        label.textAlignment = .right
        label.numberOfLines = 0
        
        return label
    }()
    
    private let descriptionLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(image)
        view.addSubview(titleLabel)
        view.addSubview(caloriesLabel)
        view.addSubview(descriptionLabel)
        
        config()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.height/10)*6)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            titleLabel.widthAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.width/5)*3)
        ])
        NSLayoutConstraint.activate([
            caloriesLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            caloriesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            caloriesLabel.widthAnchor.constraint(equalToConstant: (view.safeAreaLayoutGuide.layoutFrame.width/5)*2)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ])
    }
    
    private func config() {
        guard let dish = dish else { return }
        image.kf.setImage(with: dish.image!.asUrl)
        titleLabel.text = dish.name!
        caloriesLabel.text = "\(dish.calories!) calories"
        descriptionLabel.text = dish.description!
    }

}
