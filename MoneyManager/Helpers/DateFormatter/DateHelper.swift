//
//  DateFormatHelper.swift
//  MoneyManager
//
//  Created by Arya Ilham on 09/02/24.
//

import Foundation

class DateHelper {
    func convertToString(_ date: Date, format: String = "dd/MM/yyyy HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func convertToDate(_ dateString: String, format: String = "dd/MM/yyyy HH:mm") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let date = formatter.date(from: dateString)
        return date
    }
    
    func daysBetweenDate(from: Date, to: Date) -> Int {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.day], from: from, to: to)
        
        return components.day ?? 0
    }
}
