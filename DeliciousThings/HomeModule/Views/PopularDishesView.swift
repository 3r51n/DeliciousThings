//
//  viewssss.swift
//  DeliciousThings
//
//  Created by MacBook on 18.06.2022.
//

import UIKit

protocol ProtocolPushToDetailPopular {
    func pushDetailPopular(dish:Foods)
}

class PopularDishesView: UIView{

    private var data:[Foods] = []
    var pushProtocol:ProtocolPushToDetailPopular?
    
    let label:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popular Dishes"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    let collection:UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PopularDishesCVCell.self, forCellWithReuseIdentifier: PopularDishesCVCell.identifier)
        layout.scrollDirection = .horizontal
        
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(collection)
        
        collection.delegate = self
        collection.dataSource = self
    }
    
    public func setup(data: [Foods]) {
        self.data = data
        self.collection.reloadData()
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

extension PopularDishesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dish = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularDishesCVCell.identifier, for: indexPath) as! PopularDishesCVCell
        
        cell.setup(food: dish)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushProtocol?.pushDetailPopular(dish: data[indexPath.row])
    }
}
