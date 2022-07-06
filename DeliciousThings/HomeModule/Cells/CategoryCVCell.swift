//
//  CategoryCVCell.swift
//  DeliciousThings
//
//  Created by MacBook on 18.06.2022.
//

import UIKit
import Kingfisher

class CategoryCVCell: UICollectionViewCell {
    
    static let identifier = "Cell"
    
    let image:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "image")
        
        return image
    }()
    
    let label:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kebap"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 10
        
        addSubview(image)
        addSubview(label)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalToConstant: 40),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(category:DishCategory) {
        label.text = category.name
        image.kf.setImage(with: category.image?.asUrl)
    }
}
