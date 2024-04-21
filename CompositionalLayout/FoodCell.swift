//
//  FoodCell.swift
//  CompositionalLayout
//
//  Created by Mikhail Egorov on 09.05.2023.
//

import Foundation
import UIKit


class FoodCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "FoodCell"
    
    let friendImageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBlue
       // addSubview(label)
        label.frame = self.bounds
        //label.text = "FoodCellLabelText"
        backgroundColor = .systemTeal
    }
    
    func configure(with intValue: Int) {
        label.text = String(intValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
}
