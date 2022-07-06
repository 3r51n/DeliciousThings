//
//  viewssss.swift
//  DeliciousThings
//
//  Created by MacBook on 18.06.2022.
//

import UIKit

protocol ProtocolPushToDetailChef {
    func pushDetailChef(dish:Foods)
}

class ChefSpecialsView: UIView{
    
    private var data:[Foods] = []
    var pushProtocol:ProtocolPushToDetailChef?
    
    let label:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Chef's Specials"
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    let collection:UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ChefSpecialsCVCell.self, forCellWithReuseIdentifier: ChefSpecialsCVCell.identifier)
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
            collection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ChefSpecialsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChefSpecialsCVCell.identifier, for: indexPath) as! ChefSpecialsCVCell
        
        cell.setup(food: data[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pushProtocol?.pushDetailChef(dish: data[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 100)
    }
    
}
