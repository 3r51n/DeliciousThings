//
//  ChefSpecialsCVCell.swift
//  DeliciousThings
//
//  Created by MacBook on 22.06.2022.
//

import UIKit

class ChefSpecialsCVCell: UICollectionViewCell {
    
    static let identifier = "Cell"
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pizza"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .label
        
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
        label.text = "PizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizzaPizza"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .label
        label.numberOfLines = 0
        
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
            image.heightAnchor.constraint(equalToConstant: 90),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            caloriesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            caloriesLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            caloriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
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
