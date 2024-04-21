//
//  SelfConfiguringCell.swift
//  CompositionalLayout
//
//  Created by Mikhail Egorov on 09.05.2023.
//

import Foundation
import UIKit

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with intValue: Int)
}
