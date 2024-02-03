//
//  GHBodyLabel.swift
//  Dummy GH
//
//  Created by Vitaliy on 18.01.2024.
//

import UIKit

final class GHBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Failed to initialize")
    }
    
    convenience init(textAlingment:NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlingment
    }
    
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
