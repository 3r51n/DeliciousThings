//
//  viewssss.swift
//  DeliciousThings
//
//  Created by MacBook on 18.06.2022.
//

import UIKit

protocol ProtocolPushToCategoryDish {
    func pushCategoryDish(catName:String)
}
class FoodCategoryView: UIView {

    private var data: [DishCategory] = []
    var pushProtocol:ProtocolPushToCategoryDish?
    
    let label:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Food Category"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    let collection:UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 10)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CategoryCVCell.self, forCellWithReuseIdentifier: CategoryCVCell.identifier)
        
        return collection
    }()
    
    public func setup(data: [DishCategory]) {
        self.data = data
        self.collection.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(collection)
        
        collection.delegate = self
        collection.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: label.bottomAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FoodCategoryView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVCell.identifier, for: indexPath) as! CategoryCVCell
        
        let cat = data[indexPath.row]
        cell.setup(category: cat)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.pushProtocol?.pushCategoryDish(catName: data[indexPath.row].id!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 60)
    }
}
