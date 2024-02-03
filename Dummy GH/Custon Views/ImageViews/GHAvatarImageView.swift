//
//  GHAvatarImageView.swift
//  Dummy GH
//
//  Created by Vitaliy on 20.01.2024.
//

import UIKit

class GHAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.placeHolderImg

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func dowloadImage(fromURL url: String) {
        Task {
            image = await NetworkManager.shared.dowloadImage(from: url) ?? placeholderImage
        }
    }
}
