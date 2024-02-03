//
//  Date+Ext.swift
//  Dummy GH
//
//  Created by Vitaliy on 22.01.2024.
//

import Foundation

extension Date {
 
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month(.abbreviated).year())
    }
}
