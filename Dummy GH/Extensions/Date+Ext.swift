//
//  Date+Ext.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import Foundation

extension Date {
 
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
