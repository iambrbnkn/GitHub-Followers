//
//  UIView+Ext.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}
