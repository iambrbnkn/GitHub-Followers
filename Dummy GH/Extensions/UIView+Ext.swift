//
//  UIView+Ext.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import UIKit

extension UIView {
    
    func pinViewToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           topAnchor.constraint(equalTo: superview.topAnchor),
           leadingAnchor.constraint(equalTo: superview.leadingAnchor),
           trailingAnchor.constraint(equalTo: superview.trailingAnchor),
           bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}
