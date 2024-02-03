//
//  FollowerCell.swift
//  Dummy GH
//
//  Created by Vitaliy on 20.01.2024.
//

import UIKit
import SwiftUI

final class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        contentConfiguration = UIHostingConfiguration {
            FollowerView(follower: follower)
        }
    }
}
