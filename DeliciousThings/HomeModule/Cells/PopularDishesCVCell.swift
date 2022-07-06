//
//  PopularDishesCVCell.swift
//  DeliciousThings
//
//  Created by MacBook on 22.06.2022.
//

import UIKit
import Kingfisher



class PopularDishesCVCell: UICollectionViewCell {
    
    static let identifier = "Cell"
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pizza"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        
        return label
    }()
    
    let image:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.kf.setImage(with: URL(string: "https://www.eataly.com/wp/wp-content/uploads/2018/08/ech-quattro-mani-matt-roan-pizza-horizontal-web.jpg")!)
        
        return image
    }()
    
    let caloriesLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "120 calories"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .systemRed
        
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizza"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .label
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray6
        layer.cornerRadius = 10
        
        addSubview(titleLabel)
        addSubview(image)
        addSubview(caloriesLabel)
        addSubview(descriptionLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 140),
            image.heightAnchor.constraint(equalToConstant: 170),
            image.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            caloriesLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            caloriesLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            caloriesLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(food:Foods) {
        
        titleLabel.text = food.name!
        image.kf.setImage(with: food.image?.asUrl)
        caloriesLabel.text = "\(food.calories!) calories"
        descriptionLabel.text = food.description!
        
    }
}
